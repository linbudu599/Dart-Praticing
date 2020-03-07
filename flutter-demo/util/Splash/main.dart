import 'package:flutter/material.dart';
import 'SplashScreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "闪屏动画", theme: ThemeData.dark(), home: SplashSreen());
  }
}
