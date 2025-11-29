import 'dart:async';
import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class AIChatWidget extends StatefulWidget {
  final List<Map<String, String>> initialMessages;
  const AIChatWidget({super.key, this.initialMessages = const []});
  @override
  State<AIChatWidget> createState() => _AIChatWidgetState();
}

class _AIChatWidgetState extends State<AIChatWidget> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  StreamSubscription<String>? _sub;
  bool _streaming = false;

  @override
  void initState() {
    super.initState();
    _messages.add({'role':'system','content':'You are QuarterPay AI. Friendly, concise, confident.'});
    if (widget.initialMessages.isNotEmpty) _messages.addAll(widget.initialMessages);
  }

  void _send(String text) async {
    if (text.trim().isEmpty || _streaming) return;
    setState(() { _messages.add({'role':'user','content': text.trim()}); _messages.add({'role':'assistant','content': ''}); _streaming = true; });
    final idx = _messages.length - 1;
    final buf = StringBuffer();
    _sub = AIService.streamChat(messages: _messages).listen((chunk){
      buf.write(chunk);
      setState(() { _messages[idx]['content'] = buf.toString(); });
    }, onError: (e){
      setState(() { _messages[idx]['content'] = 'Error: $e'; _streaming = false; });
    }, onDone: (){
      setState(() { _streaming = false; });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (_, __) {
        return Material(
          elevation: 8,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(width: 48, height: 5, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 8),
              const Text('QuarterPay AI', style: TextStyle(fontWeight: FontWeight.w600)),
              const Divider(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, i) {
                    final m = _messages[i];
                    if (m['role']=='system') return const SizedBox.shrink();
                    final isUser = m['role']=='user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 700),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isUser ? Theme.of(context).colorScheme.primary.withOpacity(.1) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text(m['content'] ?? ''),
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Row(children: [
                    Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Ask anything...', border: OutlineInputBorder()), onSubmitted: _send)),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: _streaming ? null : () => _send(_controller.text), child: _streaming ? const SizedBox(width:16,height:16,child:CircularProgressIndicator(strokeWidth: 2)) : const Text('Send'))
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
