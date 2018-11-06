import 'package:flutter/material.dart';
import 'package:flutter_demo/SplashPage.dart';
import 'MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
