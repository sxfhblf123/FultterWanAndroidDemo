import "package:flutter/widgets.dart";
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: items.length,
        child: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text("Flutter初体验"),
            actions: <Widget>[
              //标题栏的菜单按钮
              new IconButton(icon: new Icon(Icons.person), onPressed: null),
            ],
            bottom: new TabBar(
              isScrollable: true,
              tabs: items.map((TabItem item) {
                return new Tab(
                  text: item.title,
                  icon: new Icon(item.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
              children: items.map((TabItem item) {
            return new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new ChoiceCard(choice: item),
            );
          }).toList()),
        ));
  }
}

class TabItem {
  const TabItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

List<TabItem> items = const <TabItem>[
  const TabItem(title: 'CAR', icon: Icons.directions_car),
  const TabItem(title: 'BICYCLE', icon: Icons.directions_bike),
  const TabItem(title: 'BOAT', icon: Icons.directions_boat),
  const TabItem(title: 'BUS', icon: Icons.directions_bus),
  const TabItem(title: 'TRAIN', icon: Icons.directions_railway),
  const TabItem(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final TabItem choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
