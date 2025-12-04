// lib/state/quarter_state.dart
import 'package:flutter/foundation.dart';

class LineChangeSegment {
  final double lineQtr;
  final DateTime startDate;
  final DateTime endDate;
  const LineChangeSegment({
    required this.lineQtr,
    required this.startDate,
    required this.endDate,
  });
  int get segmentDays => endDate.difference(startDate).inDays.clamp(0, 366);
}

class CreditUsageEntry {
  final DateTime ts;
  final double amount;
  const CreditUsageEntry(this.ts, this.amount);
}

class EscrowEntry {
  final DateTime ts;
  final double amount;
  final DateTime? appliedToBillDueDate;
  const EscrowEntry(this.ts, this.amount, {this.appliedToBillDueDate});
}

class RefundEntry {
  final DateTime ts;
  final double amount;
  const RefundEntry(this.ts, this.amount);
}

class ChargebackEntry {
  final DateTime ts;
  final double amount;
  const ChargebackEntry(this.ts, this.amount);
}

/// Quarter fee engine with anti-gaming policy (2-business-day prefund cutoff).
class QuarterState extends ChangeNotifier {
  // ---------- Singleton ----------
  static QuarterState? _instance;
  static QuarterState get instance => _instance ??= _makeDefault();

  /// Optional app-start configuration (e.g., from backend).
  static void configure({
    required DateTime quarterStartDate,
    required DateTime quarterEndDate,
    required double lineQtr,
    required double creditUsedQtr,
    double refundsSameQtr = 0.0,
    int? firstQuarterActiveDays,
    List<LineChangeSegment>? lineChangeLog,

    // optional knobs
    double? floorRate,
    double? usageRate,
    bool? enableProration,
    bool? firstQuarterProrate,
    bool? enableEoqPreview,
    bool? enableEscrowFeeReductionPreview,
    bool? enableHardshipWaiver,

    // anti-gaming & exposure
    bool? escrowReducesUsageOnlyIfPrefunded,
    int? escrowPrefundCutoffDays,
    bool? enablePeakExposureGuard,
    double? peakExposureFactorK,
    double? peakDailyExposure,
  }) {
    final qs = QuarterState(
      quarterStartDate: quarterStartDate,
      quarterEndDate: quarterEndDate,
      lineQtr: lineQtr,
      creditUsedQtr: creditUsedQtr,
      refundsSameQtr: refundsSameQtr,
      firstQuarterActiveDays: firstQuarterActiveDays,
      lineChangeLog: lineChangeLog,
    );

    if (floorRate != null) qs.floorRate = floorRate.clamp(0.0, 1.0);
    if (usageRate != null) qs.usageRate = usageRate.clamp(0.0, 1.0);
    if (enableProration != null) qs.enableProration = enableProration;
    if (firstQuarterProrate != null) qs.firstQuarterProrate = firstQuarterProrate;
    if (enableEoqPreview != null) qs.enableEoqPreview = enableEoqPreview;
    if (enableEscrowFeeReductionPreview != null) {
      qs.enableEscrowFeeReductionPreview = enableEscrowFeeReductionPreview;
    }
    if (enableHardshipWaiver != null) qs.enableHardshipWaiver = enableHardshipWaiver;

    if (escrowReducesUsageOnlyIfPrefunded != null) {
      qs.escrowReducesUsageOnlyIfPrefunded = escrowReducesUsageOnlyIfPrefunded;
    }
    if (escrowPrefundCutoffDays != null) {
      qs.escrowPrefundCutoffDays = escrowPrefundCutoffDays.clamp(0, 10);
    }

    if (enablePeakExposureGuard != null) qs.enablePeakExposureGuard = enablePeakExposureGuard;
    if (peakExposureFactorK != null) qs.peakExposureFactorK = peakExposureFactorK.clamp(0.0, 1.0);
    if (peakDailyExposure != null) qs.peakDailyExposure = _to2(_nonNeg(peakDailyExposure));

    _instance = qs;
  }

  static QuarterState _makeDefault() {
    final now = DateTime.now();
    final (start, end) = _quarterBounds(now);
    return QuarterState(
      quarterStartDate: start,
      quarterEndDate: end,
      lineQtr: 1200.00,
      creditUsedQtr: 0.00,
      refundsSameQtr: 0.00,
      lineChangeLog: const [],
    );
  }

  static (DateTime, DateTime) _quarterBounds(DateTime d) {
    final q = ((d.month - 1) ~/ 3) + 1;
    final startMonth = (q - 1) * 3 + 1;
    final start = DateTime(d.year, startMonth, 1);
    final end = DateTime(d.year, startMonth + 3, 1); // exclusive
    return (start, end);
  }

  // ---------- Constructor ----------
  QuarterState({
    required this.quarterStartDate,
    required this.quarterEndDate,
    required this.lineQtr,
    required this.creditUsedQtr,
    required this.refundsSameQtr,
    this.firstQuarterActiveDays,
    List<LineChangeSegment>? lineChangeLog,
  }) : lineChangeLog = List<LineChangeSegment>.from(lineChangeLog ?? const []);

  // ---------- Config / flags ----------
  double floorRate = 0.02; // 2%
  double usageRate = 0.07; // 7%

  bool enableEoqPreview = true;
  bool enableEscrowFeeReductionPreview = true;
  bool enableProration = true;
  bool firstQuarterProrate = true;
  bool enableHardshipWaiver = false;

  // Anti-gaming (prefund cutoff)
  bool escrowReducesUsageOnlyIfPrefunded = true;
  int escrowPrefundCutoffDays = 2; // **requested: 2 business days**

  // Optional peak exposure guard
  bool enablePeakExposureGuard = false;
  double peakExposureFactorK = 1.0;
  double? peakDailyExposure;

  // ---------- Quarter scope ----------
  final DateTime quarterStartDate;
  final DateTime quarterEndDate;
  int get totalQuarterDays =>
      quarterEndDate.difference(quarterStartDate).inDays.clamp(1, 366);
  int? firstQuarterActiveDays;

  // ---------- Inputs ----------
  double lineQtr;
  double creditUsedQtr;
  double refundsSameQtr;
  final List<LineChangeSegment> lineChangeLog;

  // Optional ledgers (future wiring)
  final List<CreditUsageEntry> creditUsageLedger = [];
  final List<EscrowEntry> escrowLedger = [];
  final List<RefundEntry> refundLedger = [];
  final List<ChargebackEntry> chargebackLedger = [];

  // ---------- Derived ----------
  double get adjustedUsed {
    final v = creditUsedQtr - refundsSameQtr;
    return v < 0 ? 0 : v;
  }

  double get usageBasis {
    final base = adjustedUsed;
    if (enablePeakExposureGuard && (peakDailyExposure ?? 0) > 0) {
      final peakComponent = (peakDailyExposure! * peakExposureFactorK);
      return base > peakComponent ? base : peakComponent;
    }
    return base;
  }

  double get feeUsage => _to2(usageBasis * usageRate);

  double get feeFloor {
    if (enableProration && lineChangeLog.isNotEmpty) {
      final totalDays = totalQuarterDays.toDouble();
      double sum = 0.0;
      for (final seg in lineChangeLog) {
        final segDays = seg.segmentDays.toDouble().clamp(0.0, totalDays);
        sum += seg.lineQtr * floorRate * (segDays / totalDays);
      }
      if (firstQuarterProrate && firstQuarterActiveDays != null) {
        final active = firstQuarterActiveDays!.toDouble().clamp(0.0, totalDays);
        return _to2(sum * (active / totalDays));
      }
      return _to2(sum);
    }

    double base = lineQtr * floorRate;
    if (firstQuarterProrate && firstQuarterActiveDays != null) {
      final total = totalQuarterDays.toDouble();
      final active = firstQuarterActiveDays!.toDouble().clamp(0.0, total);
      base = base * (active / total);
    }
    return _to2(base);
  }

  double get eoqFee => _to2(feeUsage > feeFloor ? feeUsage : feeFloor);

  /// Convenience flag for UI: does usage beat the floor?
  bool get usageWins => feeUsage >= feeFloor;

  // ---------- Mutators ----------
  void setLineQtr(double v) { lineQtr = _to2(_nonNeg(v)); notifyListeners(); }
  void setCreditUsedQtr(double v) { creditUsedQtr = _to2(_nonNeg(v)); notifyListeners(); }
  void setRefundsSameQtr(double v) { refundsSameQtr = _to2(_nonNeg(v)); notifyListeners(); }

  void setRates({double? floor, double? usage}) {
    if (floor != null) floorRate = floor.clamp(0.0, 1.0);
    if (usage != null) usageRate = usage.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setPeakExposure({double? peak, bool? enable, double? k}) {
    if (peak != null) peakDailyExposure = _to2(_nonNeg(peak));
    if (enable != null) enablePeakExposureGuard = enable;
    if (k != null) peakExposureFactorK = k.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setEscrowPolicy({bool? prefundOnly, int? cutoffDays}) {
    if (prefundOnly != null) escrowReducesUsageOnlyIfPrefunded = prefundOnly;
    if (cutoffDays != null) escrowPrefundCutoffDays = cutoffDays.clamp(0, 10);
    notifyListeners();
  }

  void setFlags({
    bool? eoqPreview,
    bool? escrowPreview,
    bool? proration,
    bool? firstQProrate,
    bool? hardship,
  }) {
    if (eoqPreview != null) enableEoqPreview = eoqPreview;
    if (escrowPreview != null) enableEscrowFeeReductionPreview = escrowPreview;
    if (proration != null) enableProration = proration;
    if (firstQProrate != null) firstQuarterProrate = firstQProrate;
    if (hardship != null) enableHardshipWaiver = hardship;
    notifyListeners();
  }

  void setLineChangeLog(List<LineChangeSegment> items) {
    lineChangeLog
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setFirstQuarterActiveDays(int? days) {
    firstQuarterActiveDays = days;
    notifyListeners();
  }

  // ---------- Helpers ----------
  static double _to2(double v) => double.parse(v.toStringAsFixed(2));
  static double _nonNeg(double v) => v < 0 ? 0 : v;
}
