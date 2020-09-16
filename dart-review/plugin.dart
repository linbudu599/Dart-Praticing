import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class ColorPlugin extends StatelessWidget {
  const ColorPlugin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "芜湖",
        style: TextStyle(color: ColorUtil.color("#ff8899")),
      ),
    );
  }
}
