import 'package:flutter/material.dart';
import 'SplashPage.dart';
import 'HomePage.dart';

void main() => runApp(new MyApp());
//void main() => runApp(new Center(
//      child: new Text("Demo", textDirection: TextDirection.ltr),
//    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Splash",
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new HomePage(),

//自定义Splash页的路由
//      routes: <String, WidgetBuilder>{
//        "/HomePage": (BuildContext context) => new HomePage()
//      },

    );
  }
}
