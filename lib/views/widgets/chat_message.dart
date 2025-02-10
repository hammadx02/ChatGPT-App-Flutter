// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../model/model.dart';

// class ChatMessageWidget extends StatelessWidget {
//   final bool loading;

//   const ChatMessageWidget({
//     super.key,
//     required this.text,
//     required this.chatMessageType,
//     this.loading = false,
//   });

//   final String text;
//   final ChatMessageType chatMessageType;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Theme.of(context).colorScheme.background,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           chatMessageType == ChatMessageType.bot
//               ? Container(
//                   margin: const EdgeInsets.only(right: 16, top: 55),
//                   child: CircleAvatar(
//                     backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
//                     child: Image.asset(
//                       'assets/chatgpt-icon.png',
//                     ),
//                   ),
//                 )
//               : Container(
//                   margin: const EdgeInsets.only(right: 16.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: CircleAvatar(
//                       child: Image.asset(
//                         'assets/user.jpeg',
//                       ),
//                     ),
//                   ),
//                 ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 if (!loading)
//                   Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                     ),
//                     child: Text(
//                       text,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                   ),
//                 if (loading)
//                   Shimmer.fromColors(
//                     baseColor: Theme.of(context)
//                         .colorScheme
//                         .onBackground
//                         .withOpacity(0.5),
//                     highlightColor: Colors.yellow,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 55),
//                       child: Text(
//                         'Loading ...',
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/model.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool loading;

  const ChatMessageWidget({
    super.key,
    required this.text,
    required this.chatMessageType,
    this.loading = false,
  });

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Bot Avatar
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16, top: 55),
                  child: CircleAvatar(
                    backgroundColor:
                        const Color.fromRGBO(0, 102, 204, 1), // DeepSeek blue
                    child: Image.asset(
                      'assets/deepseek-icon.png', // Replace with DeepSeek's icon
                      width: 24,
                      height: 24,
                      color: Colors
                          .white, // Ensure the icon is visible in dark mode
                    ),
                  ),
                )
              : // User Avatar
              Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CircleAvatar(
                      backgroundColor:
                          isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                      child: Image.asset(
                        'assets/user.jpeg',
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!loading)
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: chatMessageType == ChatMessageType.bot
                          ? isDarkTheme
                              ? const Color.fromRGBO(0, 102, 204,
                                  0.2) // Darker blue for bot messages in dark mode
                              : const Color.fromRGBO(0, 102, 204,
                                  0.1) // Light blue for bot messages in light mode
                          : isDarkTheme
                              ? Colors.grey[
                                  800] // Dark grey for user messages in dark mode
                              : Colors.grey[
                                  200], // Light grey for user messages in light mode
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: chatMessageType == ChatMessageType.bot
                                ? isDarkTheme
                                    ? Colors
                                        .white // White text for bot messages in dark mode
                                    : const Color.fromRGBO(0, 102, 204,
                                        1) // Dark blue for bot text in light mode
                                : isDarkTheme
                                    ? Colors
                                        .white // White text for user messages in dark mode
                                    : Colors
                                        .black, // Black text for user messages in light mode
                          ),
                    ),
                  ),
                if (loading)
                  Shimmer.fromColors(
                    baseColor:
                        isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!,
                    highlightColor:
                        isDarkTheme ? Colors.blue[900]! : Colors.blue[100]!,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color:
                              isDarkTheme ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          'DeepSeek is thinking...',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: isDarkTheme
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
