import 'package:flutter/material.dart';

import '../data/constants.dart';

class MadeWith extends StatelessWidget {
  const MadeWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 60),
      child: Text.rich(
        style: const TextStyle(
          fontSize: 21,
          color: iwhite70,
          fontFamily: 'Pacifico',
        ),
        TextSpan(
          text: 'made with  ',
          children: [
            WidgetSpan(
              child: Image.asset(
                'assets/heart.png',
                color: Colors.red,
                height: 35,
                width: 20,
              ),
            ),
            const TextSpan(
              text: '  by  Sahil Italiya',
            ),
          ],
        ),
      ),
    );
  }
}
