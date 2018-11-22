import 'package:flutter/material.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 * @author sxf
 * @date 2018/11/21 0021
 */
class MyDrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDrawerPage();
  }
}

class _MyDrawerPage extends State<MyDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 200,
            color: Color(0xffFFCA22),
            child: Center(
              child: new GestureDetector(
                onTap: () => Fluttertoast.showToast(msg: "登陆功能即将上线"),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/icon_head_default.png"),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("官网",
                style: TextStyle(fontSize: 20, color: Colors.black87)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage("玩Android", "http://wanandroid.com/")));
            },
          ),
          Divider(color: Colors.black45),
          ListTile(
            title: Text("关于",
                style: TextStyle(fontSize: 20, color: Colors.black87)),
            onTap: () {
              Fluttertoast.showToast(msg: "Flutter很强大");
            },
          ),
          Divider(color: Colors.black45),
        ],
      ),
    );
  }
}
