import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/**
 *WebView界面
 * @author sxf
 * @date 2018/11/2 0002
 */
class WebViewPage extends StatefulWidget {
  String title;
  String url;

  WebViewPage(this.title, this.url);

  @override
  State<StatefulWidget> createState() {
    return new _WebViewPage(title, url);
  }
}

class _WebViewPage extends State<WebViewPage> {
  String title;
  String url;

  _WebViewPage(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
      appBar: AppBar(
        backgroundColor: Color(0xffFFCA22),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
