import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * State Management Demo
 * TODO: Multiple Provider
 * TODO: Various Consume/Selector Method
 * TODO: More Complex Usage
 * TODO: TODO List Example
 */

void main() {
  // 放置在顶层 全局共享
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => HugeCounter())
    ],
    child: StateManagementDemo(),
  ));
}

class StateManagementDemo extends StatelessWidget {
  const StateManagementDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter 状态管理",
      home: HomePage(),
    );
  }
}

// 继承或混入 取决于是否需要继承其他类
/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    // 通知所有Consumer更新
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class HugeCounter extends ChangeNotifier {
  int _hugeCount = 1;
  int get hugeCount => _hugeCount;

  void incrementByTimes({int times}) {
    _hugeCount = _hugeCount * (times ?? 2);
    notifyListeners();
  }

  void decrementByTimes({int times}) {
    _hugeCount = _hugeCount ~/ (times ?? 2);
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Example'),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // const Text('You have pushed the button this many times:'),

                  /// Extracted as a separate widget for performance optimization.
                  /// As a separate widget, it will rebuild independently from [MyHomePage].
                  ///
                  /// This is totally optional (and rarely needed).
                  /// Similarly, we could also use [Consumer] or [Selector].
                  // const Count(),

                  // 每个build方法均有上下文 为了知道当前树的位置
                  // ChangeNotifier对应的实例
                  // child 优化用 builder下存在庞大子树时 不希望rebuild它
                  // 便可以把它放在child中
                  Text("Counter Cousumer"),
                  Consumer<Counter>(
                    builder: (ctx, counter, child) {
                      return Column(
                        children: <Widget>[
                          // Consumer在刷新整个widget树时会尽可能优化rebuild的widget
                          Text(
                              "Current Count By 'counter.count': ${counter.count}",
                              style: TextStyle(fontSize: 18)),
                          // 不推荐
                          Text(
                              "Current Count By 'Provider.of<counter>(ctx)': ${Provider.of<Counter>(ctx).count}",
                              style: TextStyle(fontSize: 18)),
                        ],
                      );
                    },
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 50),
                  // ),
                  // Text("Huge Counter Cousumer"),

                  // Consumer<HugeCounter>(
                  //   builder: (ctx, hugeCounter, child) {
                  //     return Column(children: <Widget>[
                  //       Text("Huge Counter: ${hugeCounter.hugeCount}",
                  //           style: TextStyle(fontSize: 18))
                  //     ]);
                  //   },
                  // ),
                  // Selector<HugeCounter, HugeCounter>(
                  //     selector: (ctx, provider) => provider,
                  //     shouldRebuild: (pre, next) => false,
                  //     builder: (ctx, hugeCounter, child) {
                  //       return Column(children: <Widget>[
                  //         RaisedButton(
                  //             onPressed: () {
                  //               hugeCounter.incrementByTimes();
                  //             },
                  //             child: Text("Increase By 2 Times")),
                  //         RaisedButton(
                  //             onPressed: () {
                  //               hugeCounter.incrementByTimes(times: 3);
                  //             },
                  //             child: Text("Increase By 3 Times")),
                  //         RaisedButton(
                  //             onPressed: () {
                  //               hugeCounter.decrementByTimes(times: 10);
                  //             },
                  //             child: Text("Decrease By 10 Times")),
                  //         RaisedButton(
                  //             onPressed: () {
                  //               hugeCounter.decrementByTimes();
                  //             },
                  //             child: Text("Decrease By 2 Times")),
                  //       ]);
                  //     })
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   /// Calls `context.read` instead of `context.watch` so that it does not rebuild
            //   /// when [Counter] changes.
            //   onPressed: () => context.read<Counter>().increment(),
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.add),
            // ),
            // floatingActionButton: Consumer<Counter>(
            //     child: Icon(Icons.add),
            //     builder: (ctx, counter, child) {
            //       return FloatingActionButton(
            //           child: child,
            //           onPressed: () {
            //             counter.increment();
            //           });
            //     })
            // 泛型: 本次使用的provider与转换后数据类型
            floatingActionButton: Selector<Counter, Counter>(
                // 如何进行转换
                selector: (ctx, provider) => provider,
                // 是否希望rebuild
                shouldRebuild: (pre, next) => false,
                // child: Icon(Icons.add),
                builder: (ctx, counter, child) {
                  print("floating action button build");
                  return Column(children: <Widget>[
                    Container(
                      height: 500,
                    ),
                    FloatingActionButton(
                        child: Icon(Icons.arrow_upward_rounded),
                        onPressed: () {
                          counter.increment();
                        }),
                    FloatingActionButton(
                        child: Icon(Icons.arrow_downward_rounded),
                        onPressed: () {
                          counter.decrement();
                        }),
                  ]);
                })));
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [MyHomePage] rebuild when [Counter] changes.
        '${context.watch<Counter>().count}',
        style: Theme.of(context).textTheme.headline4);
  }
}
