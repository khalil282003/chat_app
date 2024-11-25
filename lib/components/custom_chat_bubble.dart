import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SentChatBubble extends StatelessWidget {
  const SentChatBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        // padding: const EdgeInsets.only(
        //   left: 16,
        //   top: 16,
        //   bottom: 16,
        // ),
        // width: 170,
        // height: 65,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class RecievedChatBubble extends StatelessWidget {
  const RecievedChatBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        // padding: const EdgeInsets.only(
        //   left: 16,
        //   top: 16,
        //   bottom: 16,
        // ),
        // width: 170,
        // height: 65,
        decoration: const BoxDecoration(
            color: Color(0xff006d84),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
