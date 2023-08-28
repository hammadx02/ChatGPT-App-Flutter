import 'package:chatbot_app/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Bot',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const ChatPage(),
    );
  }
}
