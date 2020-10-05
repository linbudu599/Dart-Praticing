import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("展开")),
        body: Center(
            child: ExpansionTile(
          title: Text("Expansion Tile"),
          leading: Icon(Icons.data_usage),
          backgroundColor: Colors.white12,
          children: <Widget>[
            ListTile(
              title: Text("Item"),
              subtitle: Text("Sub Title"),
            )
          ],
          initiallyExpanded: true,
        )));
  }
}
