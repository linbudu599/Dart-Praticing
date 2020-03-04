import 'package:flutter/material.dart';

import 'pages.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "路由动画",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FirstPage());
  }
}
