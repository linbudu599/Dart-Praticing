import 'package:flutter/material.dart';
import "alive.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Keep Alive",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: KeepAliveDemo());
  }
}

class KeepAliveDemo extends StatefulWidget {
  KeepAliveDemo({Key key}) : super(key: key);

  @override
  _KeepAliveDemoState createState() => _KeepAliveDemoState();
}

class _KeepAliveDemoState extends State<KeepAliveDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    // 来自于上面的混入类
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Keep Alive"),
          bottom: TabBar(
            controller: _controller,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.add_to_photos)),
              Tab(icon: Icon(Icons.delete)),
              Tab(icon: Icon(Icons.gamepad))
            ],
          ),
        ),
        body: TabBarView(
            controller: _controller,
            children: <Widget>[Home(), Home(), Home()]));
  }
}
