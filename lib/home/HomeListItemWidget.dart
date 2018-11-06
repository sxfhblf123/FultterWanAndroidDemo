import 'package:flutter/material.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*
* 首页文章列表的item布局
* @author sxf
* @date 2018/11/2 0002
* */
class HomeListItemWidget extends StatefulWidget {
  var item;

  HomeListItemWidget(this.item);

  @override
  State<StatefulWidget> createState() {
    return new _HomeListItemWidget(item);
  }
}

class _HomeListItemWidget extends State<HomeListItemWidget> {
  var item;

  _HomeListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15, 0),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Fluttertoast.showToast(
            msg: "点击跳转文章详情",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
            bgcolor: "#e74c3c",
            textcolor: "#ffffff",
          );

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WebViewPage(item["title"], item["link"])));
        },
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //标题
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  item["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  softWrap: true,
                ),
              ),

              //描述
              new Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                alignment: Alignment.centerLeft,
                child: new Text(
                  item["desc"],
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //作者和日期
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: new Text(
                    item["author"],
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 1,
                  )),
                  new Text(
                    item["niceDate"],
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 1,
                  ),
                ],
              ),

              //类别
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: new Text(
                      item["superChapterName"],
                      style: TextStyle(color: Colors.blueAccent, fontSize: 10),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: new Text(
                      item["chapterName"],
                      style: TextStyle(color: Colors.blueAccent, fontSize: 10),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
