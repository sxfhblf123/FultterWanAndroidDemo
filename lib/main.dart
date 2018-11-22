import 'package:flutter/material.dart';
import 'package:flutter_demo/SplashPage.dart';
import 'package:flutter_demo/utils/SPUtils.dart';
import 'MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  void init() async {
    await SPUtils.getInstance();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Demo",
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{"/mainpage": (context) => new MainPage()},
    );
  }
}
