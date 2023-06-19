import 'package:flutter/material.dart';

class userMessage extends StatelessWidget {
  final String text;

  const userMessage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffdcf8c6).withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(
              left: 45,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.man,
                size: 20,
              )),
        ),
      ],
    );
  }
}
