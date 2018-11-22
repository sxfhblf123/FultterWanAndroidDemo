import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/home/HomeListItemWidget.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'package:flutter_demo/utils/SPUtils.dart';
/**
 * 搜索页面
 * @author sxf
 * @date 2018/11/6 0006
 */

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  ScrollController _listViewController = new ScrollController();
  TextEditingController _editController;
  String _editContent;
  bool _isShowDelBtn = false;

  //搜索热词的数据list
  List _listHotKey = new List();
  List<Widget> _listHotKeyWidget = new List();

  //搜索结果的数据list
  List<String> _listHistory = new List();

  //搜索列表的数据list
  List _listSearchResult = new List();

  //搜索列表接口的分页
  var curPage = 0;

  //搜索列表的总页数
  var _totalPage;
  var isRefeshing;

  @override
  void initState() {
    _editController = TextEditingController();
    _listViewController.addListener(() {
      if (_listSearchResult != null &&
          _listViewController.position.maxScrollExtent ==
              _listViewController.position.pixels &&
          _listSearchResult.length < _totalPage &&
          !isRefeshing) {
        _searchStr(_editContent);
      }
    });
    getHotKey();
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildSearchAppBar(), body: _buildSearchWidget());
  }

  //构建搜索界面的主布局
  Widget _buildSearchWidget() {
    if (_listHotKey.length < 1) {
      return new Center(
        child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xffFFCA22)),
        ),
      );
    } else {
      if (_listSearchResult.length < 1) {
        return _buildMainWidget();
      } else {
        return new ListView.builder(
          itemBuilder: (context, index) => setListViewWidget(index),
          itemCount: _listSearchResult.length,
          controller: _listViewController == null ? null : _listViewController,
        );
      }
    }
  }

  //构建搜索页面
  Widget _buildMainWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildHotKeyWidget(),
        _buildHistoryWidget(),
      ],
    );
  }

  //搜索的网络请求
  _searchStr(String content) {
    if (content != null) {
      //保存到搜索记录
      if (!_listHistory.contains(content)) {
        setState(() {
          _listHistory.add(content);
          SPUtils.putStringList(Api.SEARCH_HISTORY, _listHistory);
        });
      }
      String url = Api.BASE_URL + "/article/query/$curPage/json";
      Map<String, String> params = {"k": content};
      HttpUtils.post(url, params: params).then((response) {
        isRefeshing = false;
        if (response != null) {
          Map<String, dynamic> map = json.decode(response);
          var data = map["data"];
          if (data != null && map["errorCode"] == 0) {
            setState(() {
              _totalPage = data["total"];
              if (curPage == 0) {
                _listSearchResult = data["datas"];
              } else {
                _listSearchResult.addAll(data["datas"]);
              }
              curPage++;
            });
          }
        }
      });
    }
  }

  //搜索结果的布局
  setListViewWidget(int index) {
    return new HomeListItemWidget(_listSearchResult[index]);
  }

  //搜索热词的网络请求
  getHotKey() {
    HttpUtils.get(Api.GET_HOT_KEY_LIST).then((response) {
      isRefeshing = false;
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var data = map["data"];
        if (data != null && map["errorCode"] == 0) {
          setState(() {
            _listHotKey = data;
            _setHotWidgetList();
          });
        }
      }
    });
  }

  //构建AppBar
  AppBar _buildSearchAppBar() {
    return AppBar(
      backgroundColor: Color(0xffFFCA22),
      leading: BackButton(color: Colors.white),
      //输入框
      title: TextField(
        controller: _editController,
        textInputAction: TextInputAction.search,
        onSubmitted: (content) {
          //搜索
          curPage = 0;
          _searchStr(content);
        },
        onChanged: (content) {
          setState(() {
            if (content != null && content.isNotEmpty) {
              _editContent = content;
              _isShowDelBtn = true;
            } else {
              _isShowDelBtn = false;
            }
          });
        },
        decoration: InputDecoration(
            hintText: "发现更多干货",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none),
        maxLines: 1,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
      ),
      actions: <Widget>[
        _isShowDelBtn
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _editController.clear();
                  setState(() {
                    _isShowDelBtn = false;
                  });
                },
                color: Colors.white,
              )
            : Container(),
        //搜索按钮
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            curPage = 0;
            _searchStr(_editContent);
          },
          color: Colors.white,
        )
      ],
    );
  }

  //构建热词布局
  Widget _buildHotKeyWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 25,
          margin: EdgeInsets.fromLTRB(3, 10, 10, 0),
          child: Text(
            "热门搜索",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: _listHotKeyWidget,
        )
      ],
    );
  }

  //创建热词的Wrap布局的子控件
  _setHotWidgetList() {
    List<Widget> _widgets = new List();
    for (var value in _listHotKey) {
      _widgets.add(
        new GestureDetector(
          onTap: () {
            _searchStr(value["name"]);
          },
          child: new Container(
            padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.circular(3),
            ),
            child: new Text(
              value["name"],
              style: TextStyle(color: Colors.blueAccent, fontSize: 12),
            ),
          ),
        ),
      );
    }

    setState(() {
      _listHotKeyWidget = _widgets;
    });
  }

  Widget _buildHistoryWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 25,
          margin: EdgeInsets.fromLTRB(3, 10, 10, 0),
          child: Text(
            "搜索记录",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
        _listHistory != null && _listHistory.length > 0
            ? Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                spacing: 5,
                runSpacing: 5,
                children: _setHistoryWidgetList(),
              )
            : Container()
      ],
    );
  }

  void getHistory() async {
    List<String> list = SPUtils.getStringList(Api.SEARCH_HISTORY);
    if (list != null && list.length > 0) {
      _listHistory = list;
    }
  }

  //创建搜索历史的Wrap布局的子控件
  List<Widget> _setHistoryWidgetList() {
    List<Widget> _widgets = new List();
    for (var value in _listHistory) {
      _widgets.add(
        new GestureDetector(
          onTap: () {
            _searchStr(value);
          },
          child: new Container(
            padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.circular(3),
            ),
            child: new Text(
              value,
              style: TextStyle(color: Colors.blueAccent, fontSize: 12),
            ),
          ),
        ),
      );
    }
    return _widgets;
  }
}
