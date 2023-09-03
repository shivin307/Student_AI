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
        SizedBox(
          width: 35,
          child: SvgPicture.asset('assets/logo.svg',
            // ignore: deprecated_member_use
            color: itextColor.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Student AI',
          style: TextStyle(
              color: itextColor.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              fontSize: 30),
        )
      ],
    );
  }
}
