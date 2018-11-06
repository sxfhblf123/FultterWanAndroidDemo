import 'dart:async';
import 'package:flutter/widgets.dart';

/*
* 启动页
* @author sxf
* @date 2018/11/2 0002
* */
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
    var duration = new Duration(seconds: 2);
    new Future.delayed(duration, toHome);
  }

  void toHome() {
    Navigator.of(context).pushReplacementNamed("/mainpage");
  }
}
