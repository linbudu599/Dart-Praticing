import 'package:flutter/material.dart';
import "../utils/utils.dart";

class ButtonCollection extends StatelessWidget {
  const ButtonCollection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Button Widget")),
      // 前景色 后景色 点击时的阴影扩散
      // 迷你尺寸 自动扩充...
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          clipBehavior: Clip.antiAlias,
          child: Icon(Icons.add),
          // isExtended: true,
          mini: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              widgetTitle("IconButton"),
              /*
               * 图标按钮
               * 使用 double splashRadius 控制点击后的阴影
               * 使用 BoxConstraints constraints 约束整体大小 包括最小/最大 宽高
               */
              IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 28,
                    color: Colors.blueAccent,
                  ),
                  tooltip: 'tooltip',
                  onPressed: () {},
                  splashRadius: 48.0,
                  constraints: BoxConstraints(minWidth: 10.0)),
              widgetTitle("TextButton"),
              /**
               * 原FlatButton
               * 自带长按事件
               */
              TextButton(
                child: Text("A Text Button", style: TextStyle(fontSize: 22)),
                onPressed: () => {},
                // 裁剪行为
                // hardEdge 裁剪但不应用抗锯齿
                // antiAliasa 裁剪且抗锯齿 更平滑
                // antiAliasWithSaveLayer 抗锯齿, 且裁剪后会保存图层(?)
                clipBehavior: Clip.antiAlias,
              ),
              /**
               * 下拉菜单控件
               */
              widgetTitle("DropButton"),
              DropdownButtonDemo(),
              /**
               * 带边框的TextButton
               * 同样自带长按
               * 属性和TextButton相同
               */
              widgetTitle("OutlinedButton"),
              OutlinedButton(
                  onPressed: () {},
                  child: Text("A Outlined Text Button",
                      style: TextStyle(fontSize: 22))),
              /**
               * 类似Dropdown 主要是动画和样式区别?
               */
              widgetTitle("PopopMenuButton"),
              PopopMenuButtonDemo(),
              /**
               * 最常用的普通按钮
               * 属性全面
               * 不做列举
               */
              widgetTitle("RaisedButton"),
              RaisedButton(
                onPressed: () {},
                child: Text("A Raised Button", style: TextStyle(fontSize: 22)),
              )
              /**
               * 其他
               * ElevatedButton 自带高层级属性的按钮
               * 
               */
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonDemo extends StatefulWidget {
  DropdownButtonDemo({Key key}) : super(key: key);

  @override
  _DropdownButtonDemoState createState() => _DropdownButtonDemoState();
}

class _DropdownButtonDemoState extends State<DropdownButtonDemo> {
  final List<String> opts = ['1', '2', '3', '4'];

  String current = "1";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        // 自定义选中项渲染 List<Widget>返回是因为对选项的自定义渲染要同时给出?
        selectedItemBuilder: (BuildContext context) {
          return opts.map<Widget>((String item) {
            return Text(
              item,
              style: TextStyle(fontSize: 26),
            );
          }).toList();
        },
        value: current,
        icon: Icon(Icons.self_improvement),
        iconSize: 24,
        // 类似z-index 控制层叠层级
        elevation: 16,
        // 下拉菜单占满空间
        isExpanded: false,
        // 下拉菜单背景色
        // dropdownColor: Colors.blue,
        underline: Container(height: 2, color: Colors.blue),
        items: opts
            .map((String value) =>
                DropdownMenuItem(child: Text(value), value: value))
            .toList(),
        onChanged: (String newVal) {
          setState(() {
            current = newVal;
          });
        });
  }
}

class PopopMenuButtonDemo extends StatefulWidget {
  PopopMenuButtonDemo({Key key}) : super(key: key);

  @override
  _PopopMenuButtonDemoState createState() => _PopopMenuButtonDemoState();
}

enum Rank { a, b, c, d }

class _PopopMenuButtonDemoState extends State<PopopMenuButtonDemo> {
  Rank _selected = Rank.a;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Rank>(
        child: Text(_selected.toString(), style: TextStyle(fontSize: 26)),
        onSelected: (Rank result) {
          setState(() {
            _selected = result;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Rank>>[
              const PopupMenuItem(value: Rank.a, child: Text("a")),
              const PopupMenuItem(value: Rank.b, child: Text("b")),
              const PopupMenuItem(value: Rank.c, child: Text("c")),
              const PopupMenuItem(value: Rank.d, child: Text("d")),
            ]);
  }
}
