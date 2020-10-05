import "package:flutter/material.dart";

import 'package:dio/dio.dart';

void main() {
  runApp(DioDemo());
}

// https://github.com/flutterchina/dio/blob/master/README-ZH.md#%E8%AF%B7%E6%B1%82%E9%85%8D%E7%BD%AE

/*
 * Interceptor 执行顺序FIFO 在请求前/响应后进行操作
 * 拦截器中可以发起异步任务 进行日志打印等
 * 
 * Transformer 对请求与响应进行编解码处理
 * 只有PUT POST PATCH方法会被请求转换器处理
 * 但是所有都会被响应转换器处理
 * 
 */

// 类似于axios 当一个cancel token取消时 所有使用其的请求都会被取消
CancelToken cancelToken = CancelToken();

BaseOptions options = BaseOptions(
  baseUrl: "https://api.spacexdata.com/v4",
  headers: {},
  contentType: "application/json; charset=utf-8",
  responseType: ResponseType.json,
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options)
  ..interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    // 可以在这里直接完成掉请求并返回数据 后续then返回的数据将来自于这里
    // 直接返回Response对象或dio.resolve(data)
    options.headers = {};
    // 锁定拦截器
    dio.interceptors.requestLock.lock();
    // 进行一些操作比如获取token
    // 解锁拦截器 允许后续请求进入
    dio.interceptors.requestLock.unlock();
    // 或者调用clear清空掉后续的等待队列
    return options;
  }, onResponse: (Response response) async {
    return response;
  }, onError: (DioError e) async {
    return e; //
  }))
  ..interceptors.add(CustomInterceptors());

// 类式拦截器
class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}

class DioDemo extends StatefulWidget {
  DioDemo({Key key}) : super(key: key);

  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch().then((Response value) {
      // print(value);
      print(value.statusCode);
      print(value.request);
    }).catchError((DioError err) {
      if (CancelToken.isCancel(err)) {
        // 取消请求提示
      }
    }).whenComplete(() => {
          setState(() => {isLoading = false})
        });
  }

  Future<Response> _fetch() async {
    // 为单次请求覆盖配置
    Response response =
        await dio.get("/company", options: Options(), cancelToken: cancelToken);
    // cancelToken.cancel();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dio Demo"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Dio Usage"),
              isLoading ? Text("Loading...") : common()
            ],
          ),
        ),
      ),
    );
  }

  Widget common() {
    return Container(
      child: Text("Finished"),
    );
  }
}
