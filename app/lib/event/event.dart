import "package:flutter/material.dart";
import 'package:flutter/gestures.dart';
// Flutter对触摸事件(也称原始指针事件)的处理:
// 按下 移动 抬起,点击 双击等都是在这基础上判定的
// 按下后会执行命中测试来确定指针与屏幕接触位置存在哪些组件
// 事件会被分发到测试发现的最内部组件 并开始向上冒泡
// 但注意这个过程不可以停止

// 使用IgnorePointer与AbsorbPointer阻止子组件接收指针事件
// 前者不会参与 而后者实际上会参与
// Listener(
//   child: AbsorbPointer(
//     child: Listener(
//       child: Container(
//         color: Colors.red,
//         width: 200.0,
//         height: 100.0,
//       ),
//       onPointerDown: (event)=>print("in"),
//     ),
//   ),
//   onPointerDown: (event)=>print("up"),
// )
class EventDemo extends StatefulWidget {
  EventDemo({Key key}) : super(key: key);

  @override
  _EventDemoState createState() => _EventDemoState();
}

class _EventDemoState extends State<EventDemo> {
  // position: 相对于全局坐标偏移
  // delta: 两次移动事件距离
  // pressure: 按压力度(仅在支持压力传感器的情况下)
  // orientation: 指针移动方向
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Listener(
                // 觉得如何响应命中测试
                // 默认deferToChild: 子组件依次进行命中测试
                // 如果其子组件中有通过的 则当前组件通过
                // opaque: 使得当前Widget均为可点击区域
                // translucent: 点击组件的透明区域时对自身边界与底部可视区域均进行命中测试
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  width: 300,
                  height: 150,
                  margin: const EdgeInsets.all(20),
                  child: Text(_event?.toString() ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                ),
                onPointerDown: (PointerDownEvent event) =>
                    setState(() => _event = event),
                onPointerMove: (PointerMoveEvent event) =>
                    setState(() => _event = event),
                onPointerUp: (PointerUpEvent event) =>
                    setState(() => _event = event),
              ),
              // Stack(
              //   children: <Widget>[
              //     Listener(
              //       child: ConstrainedBox(
              //         constraints: BoxConstraints.tight(Size(300.0, 200.0)),
              //         child: DecoratedBox(
              //             decoration: BoxDecoration(color: Colors.black38)),
              //       ),
              //       onPointerDown: (event) => print("grey"),
              //     ),
              //     Listener(
              //       child: ConstrainedBox(
              //         constraints: BoxConstraints.tight(Size(200.0, 100.0)),
              //         child: DecoratedBox(
              //           decoration: BoxDecoration(color: Colors.deepOrange),
              //           child: Center(child: Text("左上角200*100范围内非文本区域点击")),
              //         ),
              //       ),
              //       onPointerDown: (event) => print("orange"),
              //       // behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
              //     )
              //   ],
              // ),

              // Container(
              //   width: 300,
              //   height: 300,
              //   child: _Drag(),
              // ),
              // Container(
              //   width: 300,
              //   height: 300,
              //   child: _DragVertical(),
              // ),
              // _ScaleTestRoute()
              _GestureRecognizerTestRoute()
            ]),
          )),
    );
  }
}

class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            // DragDownDetails:
            // globalPosition 相对于父组件左上角偏移
            // delta 每次update事件(指针之间)偏移量
            // velocity 抬起手指时速度
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}

class _DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => new _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              //垂直方向拖动事件
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              }),
        )
      ],
    );
  }
}

class _ScaleTestRoute extends StatefulWidget {
  _ScaleTestRoute({Key key}) : super(key: key);

  @override
  __ScaleTestRouteState createState() => __ScaleTestRouteState();
}

class __ScaleTestRouteState extends State<_ScaleTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.network(
            "https://avatars0.githubusercontent.com/u/48507806?s=60&v=4",
            width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

// 自定义手势监听
// GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
// 而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
// GestureDetector直接可以接收一个子widget。GestureRecognizer是一个抽象类，
// 一种手势的识别器对应一个GestureRecognizer的子类

class _GestureRecognizerTestRoute extends StatefulWidget {
  _GestureRecognizerTestRoute({Key key}) : super(key: key);

  @override
  __GestureRecognizerTestRouteState createState() =>
      __GestureRecognizerTestRouteState();
}

class __GestureRecognizerTestRouteState
    extends State<_GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "你好世界"),
        TextSpan(
          text: "点我变色",
          style: TextStyle(
              fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
          recognizer: _tapGestureRecognizer
            ..onTap = () {
              setState(() {
                _toggle = !_toggle;
              });
            },
        ),
        TextSpan(text: "你好世界"),
      ])),
    );
  }
}
