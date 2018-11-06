import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/project/ProjectListPage.dart';
import 'package:flutter_demo/utils/Api.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';


/*
* 项目的布局
* @author sxf
* @date 2018/11/2 0002
* */
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPage();
  }
}

class _ProjectPage extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<Tab> _tabs = new List();
  List<Widget> _tabViews = new List();
  TabController _tabController;

  @override
  void initState() {
    getAccountsList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xffFFCA22)),
        ),
      );
    } else {
      return Scaffold(
        appBar: new TabBar(
          controller: _tabController,
          tabs: _tabs,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          indicatorColor: Color(0xffFFCA22),
        ),
        body: _tabViews.length <= 0
            ? null
            : TabBarView(controller: _tabController, children: _tabViews),
      );
    }
  }

  void getAccountsList() {
    HttpUtils.get(Api.GET_PROJECT_LIST).then((response) {
      if (response != null) {
        Map<String, dynamic> map = json.decode(response);
        var data = map["data"];
        if (data != null && map["errorCode"] == 0) {
          setState(() {
            for (var value in data) {
              _tabs.add(Tab(
                text: value["name"],
              ));
              _tabViews.add(new ProjectListPage(value["id"]));
              _tabController = TabController(length: _tabs.length, vsync: this);
            }
          });
        }
      }
    });
  }

}

