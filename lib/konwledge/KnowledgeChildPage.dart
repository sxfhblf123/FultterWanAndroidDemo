import 'package:flutter/material.dart';
import 'package:flutter_demo/konwledge/KnowledgeListPage.dart';
/**
 * 二级知识的页面
 * @author sxf
 * @date 2018/11/2 0002
 */

class KnowledgeChildPage extends StatefulWidget {
  var data;

  KnowledgeChildPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return new _KnowledgeChildPage(data);
  }
}

class _KnowledgeChildPage extends State<KnowledgeChildPage> {
  var _data;
  List<Tab> _tabs = List();
  List<Widget> _tabBarViews = List();

  _KnowledgeChildPage(this._data);

  @override
  void initState() {
    handleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(_data["name"]),
        backgroundColor: Color(0xffFFCA22),
      ),
      body: new DefaultTabController(
        length: _data["children"].length,
        child: new Scaffold(
          appBar: TabBar(
            tabs: _tabs,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 12),
            indicatorColor: Color(0xffFFCA22),
          ),
          body: TabBarView(children: _tabBarViews),
        ),
      ),
    );
  }

  handleData() {
    var children = _data["children"];
    for (var value in children) {
      _tabs.add(Tab(
        text: value["name"],
      ));
      _tabBarViews.add(KnowledgeListPage(value["id"]));
    }
  }
}
