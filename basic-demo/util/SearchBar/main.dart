import 'package:flutter/material.dart';
import "search.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Search",
        theme: ThemeData.light(),
        home: SearchBar());
  }
}


