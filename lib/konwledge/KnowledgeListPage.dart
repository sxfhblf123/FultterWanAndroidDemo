import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:flutter_demo/home/HomeListItemWidget.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 *知识体系的文章列表
 * @author sxf
 * @date 2018/11/2 0002
 */
class KnowledgeListPage extends StatefulWidget {
  var id;

  KnowledgeListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeListPage(id);
  }
}

class _KnowledgeListPage extends State<KnowledgeListPage> {
  var id;
  List _list = new List();

  //首页列表接口的分页
  var curPage = 0;

  //首页列表的总页数
  var _totalPage;
  var isRefeshing;
  ScrollController _listViewController = new ScrollController();

  _KnowledgeListPage(this.id);

  @override
  void initState() {
    _listViewController.addListener(() {
      if (_list != null &&
          _listViewController.position.maxScrollExtent ==
              _listViewController.position.pixels &&
          _list.length < _totalPage &&
          !isRefeshing) {
        getChildrenList(false);
      }
    });

    _onRefresh();
    super.initState();
  }

  Future<Null> _onRefresh() {
    getChildrenList(true);
    return null;
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
            itemBuilder: (context, index) => setListViewWidget(index),
            itemCount: _list.length,
            controller: _listViewController,
          ),
          onRefresh: _onRefresh);
    }
  }

  void getChildrenList(bool isRefresh) {
    if (isRefresh) {
      curPage = 0;
    }
    setState(() {
      isRefeshing = true;
    });
    String url = Api.BASE_URL + "/article/list/$curPage/json?cid=$id";
    HttpUtils.get(url).then((response) {
      isRefeshing = false;
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var data = map["data"];
        if (data != null && map["errorCode"] == 0) {
          setState(() {
            _totalPage = data["total"];
            if (isRefresh) {
              _list = data["datas"];
            } else {
              _list.addAll(data["datas"]);
            }
            curPage++;
          });
        }
      }
    });
  }

  setListViewWidget(int index) {
    return new HomeListItemWidget(_list[index]);
  }
}
