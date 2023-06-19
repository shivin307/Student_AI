import 'package:flutter/material.dart';
import 'package:sgpt/widgets/ai_message.dart';
import 'package:sgpt/widgets/user_message.dart';

class MessageData extends StatelessWidget {
  const MessageData({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: sender == 'user' ? userMessage(text: text) : aiMessage(text: text),
    );
  }
}
