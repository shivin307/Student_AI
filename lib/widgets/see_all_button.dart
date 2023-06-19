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
              builder: (context) => AppScreen(),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        margin: EdgeInsets.only(right: 16),
        width: 120,
        decoration: BoxDecoration(
            color: iwhite70, borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'See All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: fwBanner,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.window,
              color: Colors.black,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
