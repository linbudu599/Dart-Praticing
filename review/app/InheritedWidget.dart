import "package:flutter/material.dart";

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationListener<IncrementNotification>(
        onNotification: (notification) {
          setState(() {
            _incrementCounter();
          });
          return true; // true: 阻止冒泡；false: 继续冒泡
        },
        child: Scaffold(
          appBar: AppBar(title: Text("xxx")),
          body: Center(
              child: Column(
            children: <Widget>[Text(_counter.toString()), _IncrementButton()],
          )),
        ),
      ),
    );
  }
}

/// 自定义通知
class IncrementNotification extends Notification {
  final String msg;
  IncrementNotification(this.msg);
}

/// 子 Widget
class _IncrementButton extends StatelessWidget {
  _IncrementButton();

  @override
  Widget build(BuildContext context) {
    // 直接获取状态
    final counter = CounterInheritedWidget.of(context).counter;
    return GestureDetector(
        onTap: () => IncrementNotification("加一").dispatch(context), // 派发通知
        child: RaisedButton(
          child: Text("+1"),
        ));
  }
}

/// 对使用自定义的 InheritedWidget 子类对状态进行封装
class CounterInheritedWidget extends InheritedWidget {
  final int counter;

  // 需要在子树中共享的数据，保存点击次数
  CounterInheritedWidget({@required this.counter, Widget child})
      : super(child: child);

  // 定义一个便捷方法，方便子树中的widget获取共享数据
  static CounterInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget old) {
    // 如果返回true，则子树中依赖(build函数中有调用)本widget
    // 的子widget的`state.didChangeDependencies`会被调用
    return old.counter != counter;
  }
}
