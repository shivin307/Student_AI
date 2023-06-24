import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class infoCard extends StatelessWidget {
  const infoCard({Key? key}) : super(key: key);

  urlLauncher(String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: itextColor,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(300),
        child: Image.asset(
          height: 230,
          width: 150,
          'assets/images/svi.png',
          fit: BoxFit.cover,
        ),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            Text(
              'Italiya & Co.',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.w500,
                color: itextColor == Colors.black ? Colors.white : Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ' © All Rights Reserved',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: itextColor == Colors.black ? Colors.white : Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => urlLauncher('https://github.com/shivin307/Student_AI'),
                  child: Image(
                    height: 30,
                    image: AssetImage('assets/github.png'),
                    color: itextColor == Colors.black ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => urlLauncher(
                      'https://www.linkedin.com/in/sahil-italiya-232124231'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/linkedin.png'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
