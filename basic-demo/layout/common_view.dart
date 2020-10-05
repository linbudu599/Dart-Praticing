import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
        alignment: const FractionalOffset(0.5, 0.8),
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: new NetworkImage(
                "https://i1.hdslb.com/bfs/face/07af796fb08f4b7a577d51fcf3b36f70b5c79f80.jpg@52w_52h.webp"),
            radius: 100.0,
          ),
          // new Container(
          //     decoration: new BoxDecoration(
          //       color: Colors.lightBlue,
          //     ),
          //     padding: EdgeInsets.all(5.0),
          //     child: new Text("FFFFFFFLUTTER"))
          new Positioned(top: 10.0, left: 10.0, child: new Text("Linbudu")),
          new Positioned(top: 10.0, right: 10.0, child: new Text("Linbudu")),
          new Positioned(top: 10.0, left: 50.0, child: new Text("Linbudu")),
        ]);
    return MaterialApp(
      title: 'Flutter Demo Row Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: new AppBar(title: new Text("水平！")),
          body: Center(child: stack)),

      // body: Center(
      //     child: new Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     new Text("Flutter!!!!"),
      //     Expanded(
      //       child: new Text("Flutttttttttttttttttttttttttttttttttter!!!!"),
      //     ),
      //     new Text("Flutter!!!!"),
      //   ],
      // ))),

      // body: new Row(
      //   children: <Widget>[
      //     Expanded(
      //         child: new RaisedButton(
      //       onPressed: () {},
      //       color: Colors.redAccent,
      //       child: new Text("Red Button"),
      //     )),
      //     Expanded(
      //         child: new RaisedButton(
      //       onPressed: () {},
      //       color: Colors.orangeAccent,
      //       child: new Text("Orange Button"),
      //     )),
      //     Expanded(
      //         child: new RaisedButton(
      //       onPressed: () {},
      //       color: Colors.blueAccent,
      //       child: new Text("Blue Button"),
      //     )),
      //   ],
      // )),
    );
  }
}
