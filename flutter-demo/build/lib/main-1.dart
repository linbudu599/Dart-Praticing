import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello! Flutter~",
        home: Scaffold(
          appBar: AppBar(title: Text("Hello! Head~~~")),
          body: Center(
              child: Container(
                  // child: Text(
                  //   "Hello! Body Hello! Body Hello! Body Hello! Body Hello! Body Hello! Body Hello! Body Hello! Body Hello! Body",
                  //   textAlign: TextAlign.center,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //       fontSize: 32.0,
                  //       color: Color.fromARGB(255, 255, 112, 123),
                  //       decoration: TextDecoration.underline,
                  //       decorationStyle: TextDecorationStyle.solid),
                  // ),
                  child: new Image.network(
                    "https://pics4.baidu.com/feed/cb8065380cd79123af044091aa1c1384b3b78019.jpeg?token=f13f3999004271d68f5bf06c79d09931&s=9182F6B0E6307B94093E95430300D0FD",
                    fit: BoxFit.fitWidth,
                    color: Colors.greenAccent,
                    colorBlendMode: BlendMode.modulate,
                    repeat: ImageRepeat.repeat,
                  ),
                  // 内部子类对齐方式
                  alignment: Alignment.topCenter,
                  width: 1000.0,
                  height: 1000.0,
                  // color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.fromLTRB(50.0, 50.0, 10, 0.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.lightBlue, Colors.greenAccent]),
                      border: Border.all(width: 5.0, color: Colors.black)))),
        ));
  }
}
