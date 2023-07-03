import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Flexible(
            flex: 5,
            child: AnimatedSplashScreen(
              animationDuration: const Duration(seconds: 1),
              backgroundColor: Colors.black87,
              splashTransition: SplashTransition.fadeTransition,
              splash: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: SvgPicture.asset(
                    'assets/openai_white.svg',
                    height: 70,
                    width: 100,
                  ),
                ),
              ),
              nextScreen: const HomeScreen(),
            ),
          ),
          // Flexible(
          //   flex: 1,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'by',
          //         style: TextStyle(
          //             color: Colors.grey,
          //             fontSize: 15,
          //             fontFamily: 'DancingScript'),
          //       ),
          //       SizedBox(
          //         height: 15,
          //       ),
          //       Text(
          //         'Italiya & Co.',
          //         style: TextStyle(
          //             fontFamily: 'DancingScript',
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.grey),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
