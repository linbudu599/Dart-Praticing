import "package:flutter/material.dart";
import "bottomApp.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter",
        // 自定义主题
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: BottomBar());
  }
}
