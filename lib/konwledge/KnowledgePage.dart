import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/konwledge/KnowledgeItemWidget.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*
* 知识体系
* @author sxf
* @date 2018/11/2 0002
* */
class KnowledgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KnowledgePage();
  }
}

class _KnowledgePage extends State<KnowledgePage> {
  List _list = new List();

  Future<Null> _onRefresh() {
    getListData();
    return null;
  }

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
      return new RefreshIndicator(
          child: new ListView.builder(
            itemBuilder: (context, index) =>
                new KnowledgeItemWidget(_list[index]),
            itemCount: _list == null ? 0 : _list.length,
          ),
          onRefresh: _onRefresh);
    }
  }

  void getListData() {
    String url = Api.GET_KNOWLEDGE_LIST;
    HttpUtils.get(url).then((response) {
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var tempData = map["data"];
        if (map["errorCode"] == 0 && tempData != null) {
          setState(() {
            _list = tempData;
          });
        } else {
          Fluttertoast.showToast(
              msg: "${map["errorMsg"]}",
              gravity: ToastGravity.BOTTOM,
              bgcolor: "#eeeeee",
              textcolor: '#ffffff');
        }
      }
    });
  }
}
