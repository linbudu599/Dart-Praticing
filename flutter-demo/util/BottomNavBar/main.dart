import "package:flutter/material.dart";
import "bottom_nav_bar.dart";

void main() => runApp(new App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo 01 Bottom Nav",
      theme: ThemeData.light(),
      home: BottomNavBar(),
    );
  }
}

