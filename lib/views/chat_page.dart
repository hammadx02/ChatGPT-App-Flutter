import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  late bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
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
          elevation: 2,
          toolbarHeight: 70,
          title: const Text(
            'ChatGpt',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.6),
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
        onPressed: () {},
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
      itemBuilder: (context, index) {},
    );
  }
}
