import 'dart:async';
import 'package:flutter/widgets.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new Image.asset("images/splash.jpg");
  }

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  void startCountDown() {
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration, toHome);
  }

  void toHome() {
    Navigator.of(context).pushReplacementNamed("/HomePage");
  }
}
