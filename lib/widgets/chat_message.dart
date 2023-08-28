import 'package:chatbot_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool loading;
  const ChatMessageWidget(
      {super.key,
      this.loading = false,
      required this.text,
      required this.chatMessageType});
  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16, top: 55),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset('assets/chatgpt_icon.png'),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!loading)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                if (loading)
                  Shimmer.fromColors(
                    baseColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    highlightColor: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Text(
                        'Loading. . .',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
