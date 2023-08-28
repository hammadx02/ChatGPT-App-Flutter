import 'package:chatbot_app/controller/generate_response.dart';
import 'package:chatbot_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  late bool isLoading;

  final List<ChatMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 70,
          title: const Text(
            'ChatGpt',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: Colors.black45,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buildInput(),
                    _buildSubmit(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      child: IconButton(
        onPressed: () {
          //display user
          setState(
            () {
              _messages.add(
                ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user,
                ),
              );
              isLoading = true;
            },
          );
          final input = _textController.text;
          _textController.clear();
          Future.delayed(Duration(milliseconds: 50))
              .then((value) => _scrollDown);

          //call chatbot api

          generateResponse(input).then(
            (value) {
              setState(
                () {
                  isLoading = false;
                  _messages.add(
                    ChatMessage(
                        text: value, chatMessageType: ChatMessageType.bot),
                  );
                },
              );
            },
          );
          _textController.clear();
          Future.delayed(Duration(milliseconds: 50)).then(
            (value) => _scrollDown(),
          );

          //display chatbot response
        },
        icon: const Icon(Icons.send_rounded),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: TextField(
          enabled: !isLoading,
          controller: _textController,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
            border: InputBorder.none,
            hintText:
                isLoading ? 'Loading . . .' : 'Write something here . . .',
          ),
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: isLoading ? _messages.length + 1 : _messages.length,
      itemBuilder: (context, index) {
        try {
          var message = _messages[index];
          return ChatMessageWidget(
              text: message.text, chatMessageType: message.chatMessageType);
        } catch (e) {
          return const ChatMessageWidget(
              loading: true,
              text: 'Loading. . .',
              chatMessageType: ChatMessageType.bot);
        }
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
