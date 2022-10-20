import 'dart:async';
import 'package:flutter/material.dart';
import 'package:star_wars_fan_app/modules/common/components/star_wars_splash_screen_image.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_strings.dart';
import 'package:star_wars_fan_app/modules/common/constants/common_styles.dart';
import 'package:star_wars_fan_app/modules/common/screens/star_wars_screen.dart';

class StarWarsSplashScreen extends StatefulWidget {
  static const String idSplashScreen = CommonStrings.idSplashScreen;

  const StarWarsSplashScreen({Key? key}) : super(key: key);
  @override
  State<StarWarsSplashScreen> createState() => _StarWarsSplashScreenState();
}

class _StarWarsSplashScreenState extends State<StarWarsSplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    startTimeout();

    super.initState();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _startApp);
  }

  _startApp() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const StarWarsMainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kSplashScreenBackgroundColor,
      body: StarWarsSplashScreenImage(),
    );
  }
}
