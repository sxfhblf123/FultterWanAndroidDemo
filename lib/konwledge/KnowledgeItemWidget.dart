import 'package:flutter/material.dart';
import 'package:flutter_demo/WebViewPage.dart';
import 'package:flutter_demo/konwledge/KnowledgeChildPage.dart';
/**
 * 知识体系的布局
 * @author sxf
 * @date 2018/11/2 0002
 */

class KnowledgeItemWidget extends StatefulWidget {
  var item;

  KnowledgeItemWidget(this.item);

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeItemWidget(item);
  }
}

class _KnowledgeItemWidget extends State<KnowledgeItemWidget> {
  var item;

  _KnowledgeItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: InkWell(
          onTap: () {
            //跳转二级目录
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => KnowledgeChildPage(item)));
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //分类名
                          Text(item["name"],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Theme.of(context).primaryColor)),
                          //知识体系
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              handleString(),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          )
                        ]),
                  ),
                  //向右的箭头
                  Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  )
                ],
              ),
              //分割线
              new Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: new Divider(
                  height: 4,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ));
  }

  String handleString() {
    var children = item["children"];
    StringBuffer stringBuffer = new StringBuffer();
    for (var value in children) {
      stringBuffer.write("${value['name']}   ");
    }
    return stringBuffer.toString();
  }
}
