import 'package:flutter/material.dart';
import "dynamic.dart";

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> views;
  int _idx = 0;

  @override
  void initState() {
    super.initState();
    views = List();
    views..add(DynamicView("Home"))..add(DynamicView("Other"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: views[_idx],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return DynamicView("New Page");
          }));
        },
        tooltip: "长按才会显示",
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.deepOrange,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.scanner, color: Colors.lightBlueAccent),
                  onPressed: () {
                    setState(() {
                      _idx = 0;
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.dashboard, color: Colors.lightBlueAccent),
                  onPressed: () {
                    setState(() {
                      _idx = 1;
                    });
                  })
            ],
          )),
    );
  }
}
