import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

/*
* 网络请求工具类（Http和 Dio两种）
* @author sxf
* @date 2018/11/2 0002
* */
class HttpUtils {
  Dio dio;
  Options options;
  static HttpUtils _instance;

  static HttpUtils get instance {
    if (_instance == null) {
      _instance = new HttpUtils();
    }
    return _instance;
  }

  HttpUtils() {
    if (dio == null) {
      options = new Options(
          baseUrl: "http://www.wanandroid.com",
          connectTimeout: 5000,
          receiveTimeout: 3000);
      dio = new Dio(options);
    }
  }

  //----------------------- http的简单封装--------------------------------------

  // get请求的封装，传入的两个参数分别是请求URL和请求参数，请求参数以map的形式传入，会在方法体中自动拼接到URL后面
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      // 如果参数不为空，则将参数拼接到URL后面
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res = await http.get(url);
    print(
        "========================================================================");
    print("response.body:${res.body}");
    print(
        "========================================================================");
    return res.body;
  }

  // post请求
  static Future<String> post(String url, {Map<String, String> params}) async {
    http.Response res = await http.post(url, body: params);
    print(
        "========================================================================");
    print("response.body:${res.body}");
    print(
        "========================================================================");
    return res.body;
  }

//----------------------- Dio库的简单封装--------------------------------------

//  get(url, {data, options, cancelToken}) async {
//    print('get请求启动! url：$url ,body: $data');
//    Response response;
//    try {
//      response = await dio.get(
//        url,
//        data: data,
//        cancelToken: cancelToken,
//      );
//      print('get请求成功!response.data：${response.data}');
//    } on DioError catch (e) {
//      if (CancelToken.isCancel(e)) {
//        print('get请求取消! ' + e.message);
//      }
//      print('get请求发生错误：$e');
//    }
//    return response.data.toString();
//  }
//
//  post(url, {data, options, cancelToken}) async {
//    print('post请求启动! url：$url ,body: $data');
//    Response response;
//    try {
//      response = await dio.post(
//        url,
//        data: data,
//        cancelToken: cancelToken,
//      );
//      print('post请求成功!response.data：${response.data}');
//    } on DioError catch (e) {
//      if (CancelToken.isCancel(e)) {
//        print('post请求取消! ' + e.message);
//      }
//      print('post请求发生错误：$e');
//    }
//    return response.data.toString();
//  }
}
