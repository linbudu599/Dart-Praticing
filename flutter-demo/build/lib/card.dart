import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var card = new Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text("111111", style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
              Text("22222", style: TextStyle(fontWeight: FontWeight.w400)),
          leading: new Icon(Icons.add_alert, color: Colors.lightBlueAccent),
        ),
        new Divider(
          thickness: 10.0,
          height: 10.0,
        ),
        ListTile(
          title: Text("111111", style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
              Text("22222", style: TextStyle(fontWeight: FontWeight.w400)),
          leading: new Icon(Icons.add_alert, color: Colors.lightBlueAccent),
        ),
        new Divider(
          thickness: 10.0,
          height: 10.0,
        ),
        ListTile(
          title: Text("111111", style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
              Text("22222", style: TextStyle(fontWeight: FontWeight.w400)),
          leading: new Icon(Icons.add_alert, color: Colors.lightBlueAccent),
        )
      ],
    ));

    return MaterialApp(
      title: 'Flutter Demo Row Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: new AppBar(title: new Text("卡片式布局！")),
          body: Center(child: card)),
    );
  }
}
