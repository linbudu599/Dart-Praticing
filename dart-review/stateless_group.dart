import 'package:flutter/material.dart';
import "components/BackBtn.dart";

class StatelessGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyleCommon = TextStyle(fontSize: 24);
    return MaterialApp(
      title: 'Stateless Widget Group',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text("Stateless Widget 基础组件"),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back))),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text("芜湖!起飞", style: textStyleCommon),
              Icon(Icons.access_alarm, size: 50, color: Colors.blue),
              CloseButton(),
              BackButton(),
              Chip(
                  avatar: Icon(
                    Icons.person,
                  ),
                  label: Text("1111")),
              Divider(height: 10, indent: 10, color: Colors.orange),
              Card(
                  color: Colors.blue,
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Cardddd", style: textStyleCommon))),
              AlertDialog(title: Text("Alert"), content: Text("芜湖!"))
            ],
          ),
        ),
      ),
    );
  }
}
