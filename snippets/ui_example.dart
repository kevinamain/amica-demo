import 'package:flutter/material.dart';

void main() => runApp(const AmicaDemo());

class AmicaDemo extends StatelessWidget {
  const AmicaDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amica Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF9C27B0), 
        scaffoldBackgroundColor: const Color(0xFFF7F7FA),
      ),
      home: const DemoChatScreen(),
    );
  }
}

class DemoChatScreen extends StatefulWidget {
  const DemoChatScreen({super.key});
  @override
  State<DemoChatScreen> createState() => _DemoChatScreenState();
}

class _DemoChatScreenState extends State<DemoChatScreen> {
  final _controller = TextEditingController();
  String _mode = 'Friend';
  final List<_Msg> _messages = <_Msg>[
    _Msg('Hi, I’m Amica. This is a demo-only UI — no production code here.', false),
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text, true));
      _controller.clear();
      
      _messages.add(_Msg(_demoReply(text, _mode), false));
    });
  }

  String _demoReply(String user, String mode) {
    switch (mode) {
      case 'Mentor':
        return 'Mentor: Great step. Try a 20–30 min focus sprint next. Keep it measurable.';
      case 'Therapist':
        return 'Therapist: I hear you. What emotion feels loudest right now? Let’s name it together.';
      case 'Romantic':
        return 'Romantic: Aww, that’s sweet. Tell me more—what made your day better?';
      default:
        return 'Friend: Got it! I’m cheering for you. What’s one small win we can aim for today?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amica — Demo Chat'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _mode,
                items: const [
                  DropdownMenuItem(value: 'Friend', child: Text('Friend')),
                  DropdownMenuItem(value: 'Romantic', child: Text('Romantic')),
                  DropdownMenuItem(value: 'Mentor', child: Text('Mentor')),
                  DropdownMenuItem(value: 'Therapist', child: Text('Therapist')),
                ],
                onChanged: (v) => setState(() => _mode = v ?? 'Friend'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _ChatBubble(msg: _messages[i]),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Message Amica (demo)…',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Msg {
  final String text;
  final bool isUser;
  _Msg(this.text, this.isUser);
}

class _ChatBubble extends StatelessWidget {
  final _Msg msg;
  const _ChatBubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isUser = msg.isUser;
    final bg = isUser ? const Color(0xFFE0D7F6) : Colors.white;
    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isUser ? 16 : 4),
      bottomRight: Radius.circular(isUser ? 4 : 16),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          msg.text,
          style: const TextStyle(fontSize: 15, height: 1.35),
        ),
      ),
    );
  }
}
