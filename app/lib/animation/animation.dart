import "package:flutter/material.dart";

class AnimationDemo extends StatelessWidget {
  const AnimationDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Animation Demo")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[],
            ),
          ),
        ));
  }
}
