import "package:flutter/material.dart";
import 'package:provider/provider.dart';

void main() {
  runApp(InheritedWidgetContainer());
}

class Counter {
  final int count;
  const Counter(this.count);
}

class SharedContext extends InheritedWidget {
  final Counter counter;

  final void Function() increment;
  final void Function() decrement;

  SharedContext(
      {Key key,
      @required this.counter,
      @required this.increment,
      @required this.decrement,
      @required Widget child})
      : super(key: key, child: child);

  static SharedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedContext>();
  }

  @override
  bool updateShouldNotify(SharedContext oldContext) {
    return true;
  }
}

class IncreWidget extends StatelessWidget {
  const IncreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inheritedCtx = SharedContext.of(context);
    final counter = inheritedCtx.counter;

    print("Count Value in IncreWidget: ${counter.count}");

    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: RaisedButton(
          color: Colors.white,
          onPressed: inheritedCtx.increment,
          child: Text(
            "+",
            style: TextStyle(fontSize: 32, color: Colors.green),
          ),
        ));
  }
}

class DecreWidget extends StatelessWidget {
  const DecreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inheritedCtx = SharedContext.of(context);
    final counter = inheritedCtx.counter;

    print("Count Value in DecreWidget: ${counter.count}");

    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: RaisedButton(
          color: Colors.white,
          onPressed: inheritedCtx.decrement,
          child: Text(
            "-",
            style: TextStyle(fontSize: 32, color: Colors.redAccent),
          ),
        ));
  }
}

class ValueWidget extends StatefulWidget {
  ValueWidget({Key key}) : super(key: key);

  @override
  _ValueWidgetState createState() => _ValueWidgetState();
}

class _ValueWidgetState extends State<ValueWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }

  @override
  Widget build(BuildContext context) {
    final inheritedCtx = SharedContext.of(context);
    final counter = inheritedCtx.counter;

    print("Count Value in ValueWidget: ${counter.count}");

    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        "count: ${counter.count}",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}

class InheritedWidgetContainer extends StatefulWidget {
  InheritedWidgetContainer({Key key}) : super(key: key);

  @override
  _InheritedWidgetContainerState createState() =>
      _InheritedWidgetContainerState();
}

class _InheritedWidgetContainerState extends State<InheritedWidgetContainer> {
  Counter counter;

  void _initialization() {
    counter = new Counter(0);
  }

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void _increment() {
    setState(() {
      counter = new Counter(counter.count + 1);
    });
  }

  void _decrement() {
    setState(() {
      counter = new Counter(counter.count - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedContext(
      counter: counter,
      increment: _increment,
      decrement: _decrement,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("基于 InheritedWidget 的 Flutter状态管理"),
          ),
          body: Center(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IncreWidget(),
                ValueWidget(),
                DecreWidget(),
                // Text(counter.count.toString()),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
