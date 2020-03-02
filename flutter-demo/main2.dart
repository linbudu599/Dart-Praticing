import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "子页面返回数据", home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("获取数据"),
          ),
          body: Center(child: RouteButton())),
    );
  }
}

class RouteButton extends StatelessWidget {
  const RouteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () {
          _navigateToXjj(context);
        },
        child: Text("去获取数据~"));
  }

  _navigateToXjj(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Xjj()));

    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
  }
}

class Xjj extends StatelessWidget {
  const Xjj({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("XJJ")),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("1号"),
              onPressed: () {
                Navigator.pop(context, "1haohaohao");
              }),
          RaisedButton(
              child: Text("2号"),
              onPressed: () {
                Navigator.pop(context, "2haohaohao");
              }),
          new Image.asset("assets/11.jpg")
        ],
      )),
    );
  }
}
