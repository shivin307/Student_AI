import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgpt/data/constants.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 35,
          child: SvgPicture.asset( itextColor == Colors.white ?
            'assets/openai_white.svg': 'assets/openai_black.svg',
            color: itextColor.withOpacity(0.8),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Student AI',
          style: TextStyle(
              color: itextColor.withOpacity(0.8), fontWeight: FontWeight.w600, fontSize: 30),
        )
      ],
    );
  }
}
