import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
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
            const Text(
              'Italiya & Co.',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              ' © All Rights Reserved',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => urlLauncher('https://github.com/shivin307'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/github.png'),
                    color: Colors.black,
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
