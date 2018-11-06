import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';

/**
 * 导航的页面
 * @author sxf
 * @date 2018/11/5 0005
 */
class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationPage();
  }
}

class _NavigationPage extends State<NavigationPage> {
  List _list = new List();
  int _clikIndex = 0;

  List<Widget> _listWidget = new List();

  @override
  void initState() {
    getListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_list.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xffFFCA22)),
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            width: 100,
            child: ListView.builder(
              itemBuilder: (context, index) => _setSortItem(index),
              itemCount: _list.length,
            ),
          ),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: _listWidget,
            ),
          ),
        ],
      );
    }
  }

  void getListData() {
    HttpUtils.get(Api.GET_GAVITION_LIST).then((response) {
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var data = map["data"];
        if (data != null && map["errorCode"] == 0) {
          setState(() {
            _list = data;
            _setWidgetList(_list[0]);
          });
        }
      }
    });
  }

  _setSortItem(int index) {
    return new GestureDetector(
        onTap: () {
          setState(() {
            _clikIndex = index;
            _setWidgetList(_list[index]);
          });
        },
        child: new Container(
          color: _clikIndex == index ? Colors.white : Color(0xffeeeeee),
          height: 40,
          child: Center(
            child: Text(_list[index]["name"]),
          ),
        ));
  }

  _setWidgetList(var sortBean) {
    List _list = sortBean["articles"];
    List<Widget> _widgets = new List();
    for (var value in _list) {
      _widgets.add(
        new GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage(value["title"], value["link"])));
          },
          child: new Container(
            padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.circular(3),
            ),
            child: new Text(
              value["title"],
              style: TextStyle(color: Colors.blueAccent, fontSize: 18),
            ),
          ),
        ),
      );
    }

    setState(() {
      _listWidget = _widgets;
    });
  }
}
