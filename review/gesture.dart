import "package:flutter/material.dart";

class Gesture extends StatefulWidget {
  Gesture({Key key}) : super(key: key);

  @override
  _GestureState createState() => _GestureState();
}

class _GestureState extends State<Gesture> {
  String printMsg = '';
  double moveX = 0, moveY = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
            title: Text("手势处理"),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.gesture)),
          ),
          body: FractionallySizedBox(
              widthFactor: 1,
              child: Stack(
                children: <Widget>[
                  Column(children: <Widget>[
                    GestureDetector(
                        onTap: () => _printMsg("点击"),
                        onDoubleTap: () => _printMsg("双击"),
                        onLongPress: () => _printMsg("长按"),
                        onTapCancel: () => _printMsg("取消"),
                        onTapUp: (TapUpDetails ev) => _printMsg("松开"),
                        onTapDown: (TapDownDetails ev) => _printMsg("按下"),
                        child: Container(
                          padding: EdgeInsets.all(60),
                          decoration: BoxDecoration(color: Colors.blueAccent),
                          child: Text("Click Me",
                              style:
                                  TextStyle(fontSize: 36, color: Colors.white)),
                        )),
                    Text(printMsg),
                  ]),
                  Positioned(
                      left: moveX,
                      top: moveY,
                      child: GestureDetector(
                          onPanUpdate: (e) => _move(e),
                          child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(36)))))
                ],
              )),
        ),
      ),
    );
  }

  void _printMsg(String msg) {
    setState(() {
      printMsg += ' ,$msg';
    });
  }

  void _move(DragUpdateDetails e) {
    setState(() {
      moveX += e.delta.dx;
      moveY += e.delta.dy;
    });
  }
}
