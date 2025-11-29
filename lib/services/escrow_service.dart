import 'dart:async';

class EscrowService {
  static const double quarterlyTarget = 342.0; // 0% fee threshold
  static const double exampleLocked = 114.0;   // 33% progress

  static final _controller = StreamController<double>.broadcast();
  static double _current = exampleLocked;

  static Stream<double> get stream => _controller.stream;
  static double get current => _current;

  static void addRoundUp(double cents) {
    _current += cents;
    _controller.add(_current);
  }

  static void setAmount(double v) { _current = v; _controller.add(_current); }
}
