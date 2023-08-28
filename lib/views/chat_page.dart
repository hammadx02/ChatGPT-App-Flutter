import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 2,
          toolbarHeight: 70,
          title: const Text(
            'ChatGpt',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.6),
          ),
        ),
      ),
    );
  }
}
