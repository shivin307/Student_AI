import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 35,
          child: SvgPicture.asset(
            'assets/openai_white.svg',
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Student AI',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
        )
      ],
    );
  }
}