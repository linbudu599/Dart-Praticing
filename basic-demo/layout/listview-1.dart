import "package:flutter/material.dart";

void main() => runApp(MyApp(items: new List<int>.generate(100, (i) => i)));

class MyApp extends StatelessWidget {
  final List<int> items;

  // ?
  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello! Flutter~",
      home: Scaffold(
          appBar: new AppBar(title: new Text("Hello")),
          // body: new Text("ListView!"),
          // body: Center(child: Container(height: 200.0, child: MyList())),
          body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => new ListTile(
                title: new Text("Item $index -> $context = ${items[index]}")),
          )),
    );
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 100.0,
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(10.0),
        ),
        new Container(
          width: 100.0,
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(10.0),
        ),
      ],
    );
  }
}
