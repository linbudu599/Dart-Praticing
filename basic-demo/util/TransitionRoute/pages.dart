import "package:flutter/material.dart";
import "customRouter.dart";

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text("First Page", style: TextStyle(fontSize: 36.0)),
          elevation: 0.0,
        ),
        body: Center(
          child: MaterialButton(
            child: Icon(Icons.navigate_next, color: Colors.white, size: 64.0),
            onPressed: () {
              Navigator.of(context).push(CustomRoute(SecondPage()));
            },
          ),
        ));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text("Second Page", style: TextStyle(fontSize: 36.0)),
        backgroundColor: Colors.orange,
        leading: Container(),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(Icons.navigate_before, color: Colors.white, size: 64.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
