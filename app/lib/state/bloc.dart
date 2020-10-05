import "package:flutter/material.dart";

void main() {
  runApp(BLOCApp());
}

class BLOCApp extends StatelessWidget {
  const BLOCApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: Scaffold(
        appBar: AppBar(
          title: Text("State Managemeent By BLOC Pattern"),
        ),
        body: Center(
          child: Text("2"),
        ),
      ),
    );
  }
}
