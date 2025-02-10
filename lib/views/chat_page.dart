// import 'package:chatbot_app/views/widgets/chat_message.dart';
// import 'package:flutter/material.dart';

// import '../controller/generate_response.dart';
// import '../model/model.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final _textController = TextEditingController();

//   final _scrollController = ScrollController();

//   final List<ChatMessage> _messages = [];

//   late bool isLoading;

//   TextEditingController messageTextController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         toolbarHeight: 70,
//         elevation: 2,
//         title: const Text(
//           "ChatGPT",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             letterSpacing: 0.6,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: _buildList(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   _buildInput(),
//                   _buildSubmit(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmit() {
//     return Visibility(
//       visible: !isLoading,
//       child: IconButton(
//         icon: const Icon(
//           Icons.send_rounded,
//         ),
//         onPressed: () async {
//           setState(
//             () {
//               _messages.add(
//                 ChatMessage(
//                   text: _textController.text,
//                   chatMessageType: ChatMessageType.user,
//                 ),
//               );
//               isLoading = true;
//             },
//           );
//           final input = _textController.text;
//           _textController.clear();
//           Future.delayed(const Duration(milliseconds: 50))
//               .then((_) => _scrollDown());
//           generateResponse(input).then((value) {
//             setState(() {
//               isLoading = false;
//               _messages.add(
//                 ChatMessage(
//                   text: value,
//                   chatMessageType: ChatMessageType.bot,
//                 ),
//               );
//             });
//           });
//           _textController.clear();
//           Future.delayed(const Duration(milliseconds: 50)).then(
//             (_) => _scrollDown(),
//           );
//         },
//       ),
//     );
//   }

//   Expanded _buildInput() {
//     return Expanded(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(90),
//         child: TextField(
//           enabled: !isLoading,
//           textCapitalization: TextCapitalization.sentences,
//           controller: _textController,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor:
//                 Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
//             border: InputBorder.none,
//             hintText: isLoading ? 'Loading ...' : 'Write something here . . .',
//           ),
//         ),
//       ),
//     );
//   }

//   ListView _buildList() {
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: isLoading ? _messages.length + 1 : _messages.length,
//       itemBuilder: (context, index) {
//         try {
//           var message = _messages[index];
//           return ChatMessageWidget(
//             text: message.text,
//             chatMessageType: message.chatMessageType,
//           );
//         } catch (e) {
//           return const ChatMessageWidget(
//             text: "Loading ...",
//             loading: true,
//             chatMessageType: ChatMessageType.bot,
//           );
//         }
//       },
//     );
//   }

//   void _scrollDown() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }
// }

import 'package:chatbot_app/views/widgets/chat_message.dart';
import 'package:flutter/material.dart';

import '../controller/generate_response.dart';
import '../model/model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 2,
        title: const Text(
          "DeepSeek Chat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
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
                  _buildInput(isDarkTheme),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: IconButton(
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.blue, // Use DeepSeek's primary color
        ),
        onPressed: () async {
          setState(() {
            _messages.add(
              ChatMessage(
                text: _textController.text,
                chatMessageType: ChatMessageType.user,
              ),
            );
            isLoading = true;
          });

          final input = _textController.text;
          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());

          generateResponse(input).then((value) {
            setState(() {
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: value,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
          });

          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());
        },
      ),
    );
  }

  Expanded _buildInput(bool isDarkTheme) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: TextField(
          enabled: !isLoading,
          textCapitalization: TextCapitalization.sentences,
          controller: _textController,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkTheme
                ? Colors.grey[800]!
                    .withOpacity(0.5) // Dark theme input background
                : Colors.grey[200]!
                    .withOpacity(0.5), // Light theme input background
            border: InputBorder.none,
            hintText: isLoading
                ? 'DeepSeek is thinking...'
                : 'Write something here . . .',
            hintStyle: TextStyle(
              color: isDarkTheme ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black, // Text color
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
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        } catch (e) {
          return const ChatMessageWidget(
            text: "Loading ...",
            loading: true,
            chatMessageType: ChatMessageType.bot,
          );
        }
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
