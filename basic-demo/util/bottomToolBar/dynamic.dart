import 'package:flutter/material.dart';

class DynamicView extends StatefulWidget {
  String _title;
  DynamicView(this._title);
  @override
  _DynamicViewState createState() => _DynamicViewState();
}

class _DynamicViewState extends State<DynamicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget._title)),
        body: Center(child: Text(widget._title)));
  }
}
