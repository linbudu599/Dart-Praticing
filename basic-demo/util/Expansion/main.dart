import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Wrap 流式布局", theme: ThemeData.light(), home: ExpansionTileDemo());
  }
}
