import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * 基于Provider的Flutter状态管理
 */

void main() {
  // 放置在顶层 全局共享
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Counter(),
        lazy: true,
      ),
      ProxyProvider<Counter, Transform>(
          update: (_, counter, __) => Transform(counter.count))
    ],
    child: ProviderDemo(),
  ));
}

class ProviderDemo extends StatelessWidget {
  const ProviderDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "基于Provider的 Flutter 状态管理",
      home: HomePage(),
    );
  }
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class Transform {
  final int _value;

  const Transform(this._value);

  String get transformed => "U clicked $_value times";
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build");
    return Center(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Provider Example'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Counter Cousumer",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Consumer<Counter>(
                    builder: (ctx, counter, child) {
                      return Column(
                        children: <Widget>[
                          const Count(),
                          _text(context, "Consumer: ${counter.count}"),
                          // 不推荐
                          _text(context,
                              'Provider.of<counter>(ctx): ${Provider.of<Counter>(ctx).count}')
                        ],
                      );
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Transformed Counter Cousumer",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Consumer<Transform>(
                    builder: (ctx, transform, child) {
                      return Column(
                        children: <Widget>[
                          _text(context,
                              "read: ${context.read<Transform>().transformed}"),
                          _text(context, 'Consumer: ${transform.transformed}'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => context.read<Counter>().increment(),
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.add),
            // ),
            floatingActionButton: Consumer<Counter>(
                child: Icon(Icons.add),
                builder: (ctx, counter, child) {
                  return FloatingActionButton(
                      child: child,
                      onPressed: () {
                        counter.increment();
                      });
                })
            // 泛型: 本次使用的provider与转换后数据类型
            // floatingActionButton: Selector<Counter, Counter>(
            //     // 如何进行转换
            //     selector: (ctx, provider) => provider,
            //     // 是否希望rebuild
            //     shouldRebuild: (pre, next) => false,
            //     // child: Icon(Icons.add),
            //     builder: (ctx, counter, child) {
            //       print("floating action button build");
            //       return Column(children: <Widget>[
            //         Container(
            //           height: 500,
            //         ),
            //         FloatingActionButton(
            //             child: Icon(Icons.arrow_upward_rounded),
            //             onPressed: () {
            //               counter.increment();
            //             }),
            //         FloatingActionButton(
            //             child: Icon(Icons.arrow_downward_rounded),
            //             onPressed: () {
            //               counter.decrement();
            //             }),
            //       ]);
            //     }

            //     )
            ));
  }
}

Widget _text(BuildContext context, String text) {
  return Text(text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500));
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _text(context,
        'Extract Count to a separate widget & [context.watch]: ${context.watch<Counter>().count}');
  }
}
