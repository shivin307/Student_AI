import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/screens/splash_screen.dart';
import 'package:wiredash/wiredash.dart';

import 'data/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      feedbackOptions: const WiredashFeedbackOptions(
        labels: [
          Label(
            id: label1,
            title: 'Improvement',
          ),
          Label(
            id: label2,
            title: 'Feature Request',
          ),
          Label(
            id: label3,
            title: 'Bug',
          ),
        ],
      ),
      theme: WiredashThemeData.fromColor(
        primaryColor: iradium,
        secondaryColor: ichatColor,
        brightness: Brightness.dark,
      ),
      projectId: projectId,
      secret: secretKey,
      child: MaterialApp(
        title: 'Student AI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          useMaterial3: true,
          textTheme: GoogleFonts.getTextTheme('Ubuntu'),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
