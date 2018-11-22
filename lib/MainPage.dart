import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:flutter_demo/MyDrawerPage.dart';
import 'package:flutter_demo/konwledge/KnowledgePage.dart';
import 'package:flutter_demo/project/ProjectPage.dart';
import 'package:flutter_demo/home/HomePage.dart';
import 'package:flutter_demo/accounts/AccountsPage.dart';
import 'package:flutter_demo/navigation/NavigationPage.dart';
import 'package:flutter_demo/search/SearchPage.dart';

/*
* 主页面
* @author sxf
* @date 2018/11/2 0002
* */
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  var _tabIndex = 0;
  var _bottomTitles = ["首页", "知识体系", "公众号", "导航", "项目"];
  var _tabImages;
  var _bodys;

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

/*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][0];
    }
    return _tabImages[curIndex][1];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(_bottomTitles[curIndex],
          style: new TextStyle(color: const Color(0xffFFCA22)));
    } else {
      return new Text(_bottomTitles[curIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }

  void initData() {
    _tabImages = [
      [
        getTabImage("images/ic_home_select.png"),
        getTabImage("images/ic_home_unselect.png")
      ],
      [
        getTabImage("images/ic_knowledge_select.png"),
        getTabImage("images/ic_knowledge_unselect.png")
      ],
      [
        getTabImage("images/ic_weixin_select.png"),
        getTabImage("images/ic_weixin_unselect.png")
      ],
      [
        getTabImage("images/ic_navigation_select.png"),
        getTabImage("images/ic_navigation_unselect.png")
      ],
      [
        getTabImage("images/ic_project_select.png"),
        getTabImage("images/ic_project_unselect.png")
      ],
    ];
    _bodys = [
      new HomePage(),
      new KnowledgePage(),
      new AccountsPage(),
      new NavigationPage(),
      new ProjectPage(),
    ];
  }

  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      key: _scaffoldkey,
      //标题栏
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFFCA22),
        title: Text(_tabIndex == 0 ? 'Flutter初体验' : _bottomTitles[_tabIndex]),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                var snackBar = new SnackBar(
                  content: new Text("点击搜索按钮"),
                  duration: Duration(milliseconds: 1000),
                );
                _scaffoldkey.currentState.showSnackBar(snackBar);

                //跳转搜索页面
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              })
        ],
      ),

      //抽屉布局
      drawer: MyDrawerPage(),

      //底部导航
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: getTabIcon(2), title: getTabTitle(2)),
          new BottomNavigationBarItem(
              icon: getTabIcon(3), title: getTabTitle(3)),
          new BottomNavigationBarItem(
              icon: getTabIcon(4), title: getTabTitle(4)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
      body: _bodys[_tabIndex],
    );
  }
}
