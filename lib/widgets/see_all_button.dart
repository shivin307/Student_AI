import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';

import '../screens/app_screen.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print('See all pressed!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppScreen(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        margin: const EdgeInsets.only(right: 16),
        width: 120,
        decoration: BoxDecoration(
            color: itextColor == Colors.black
                ? Colors.black.withOpacity(0.7)
                : iwhite70,
            borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'See All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: fwBanner,
                color: itextColor == Colors.black
                    ? Colors.white.withOpacity(0.8)
                    : Colors.black.withOpacity(0.8),
              ),
            ),
            Icon(
              Icons.window,
              color: itextColor == Colors.black
                  ? Colors.white.withOpacity(0.8)
                  : Colors.black.withOpacity(0.8),
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
