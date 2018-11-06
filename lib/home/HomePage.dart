import 'package:flutter/material.dart';
import 'package:banner/banner.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:flutter_demo/home/HomeListItemWidget.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'dart:convert';

/*
* 首页
* @author sxf
* @date 2018/11/2 0002
* */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  var _scaffoldkey = new GlobalKey<ScaffoldState>();
  ScrollController _listViewController = new ScrollController();

  //banner数据
  var _bannerData;

  //首页列表的数据list
  List _list = new List();

  //首页列表接口的分页
  var curPage = 0;

  //首页列表的总页数
  var _totalPage;
  var isRefeshing;

  @override
  void initState() {
    _listViewController.addListener(() {
      if (_list != null &&
          _listViewController.position.maxScrollExtent ==
              _listViewController.position.pixels &&
          _list.length < _totalPage &&
          !isRefeshing) {
        getListData(false);
      }
    });

    _onRefresh();
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
            itemBuilder: (context, index) => setListViewWidget(index),
            itemCount: _list.length + 1,
            controller:
                _listViewController == null ? null : _listViewController,
          ),
          onRefresh: _onRefresh);
    }
  }

  //创建ListView的Item
  setListViewWidget(int index) {
    if (index == 0) {
      return new BannerView(
        data: _bannerData,
        buildShowView: (index, data) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage(data["title"], data["url"])));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  child: Image.network(
                    data["imagePath"],
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0x44000000),
                    padding: EdgeInsets.all(8.0),
                    child: Text(data["title"],
                        style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  ),
                )
              ],
            ),
          );
        },
        onBannerClickListener: (index, data) {
          print(data);
        },
        delayTime: 3,
        scrollTime: 1,
      );
    } else {
      return new HomeListItemWidget(_list[index - 1]);
    }
  }

  //获取banner数据
  getBannerData() async {
    String url = Api.GET_BANNER;
    HttpUtils.get(url).then((response) {
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var data = map["data"];
        if (data != null && map["errorCode"] == 0) {
          setState(() {
            _bannerData = data;
          });
        }
      }
    });
  }

  //获取首页列表数据
  void getListData(bool isRefresh) {
    if (isRefresh) {
      curPage = 0;
    }
    setState(() {
      isRefeshing = true;
    });
    String url = Api.BASE_URL + "/article/list/$curPage/json";
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

  Future<Null> _onRefresh() {
    getBannerData();
    getListData(true);
    return null;
  }
}
