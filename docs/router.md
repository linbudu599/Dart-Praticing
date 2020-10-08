# 路由

1. 在MaterialApp的routes(<String, WidgetBuilder>{})中进行注册:

```dart
"button_collection": (BuildContext context) => ButtonCollection()
```

2. push / pushNamed

通常是前者动态, 后者静态路由

push可以不用注册, 在用到的时候才进行构造

pushNamed需要注册(在routes中)

```dart
 _item(String title, Widget page, String route, [ScreenArgs args]) {
    return Container(
        child: RaisedButton(
            onPressed: () {
              if (routeByName) {
                Navigator.pushNamed(context, route, arguments: args);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => page,
                        settings: RouteSettings(arguments: args)));
              }
            },
            child: Text(title)));
  }
```

3. 返回时携带数据

方式一:

```dart
 // 用一个异步方法, 等待路由跳转返回结果
 Future<void> _navigateToSelectPage(BuildContext context) async {
    final dynamic result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ReturnData2HomeScreen()));

    setState(() {
      selectText = result;
    });

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text("U Select $result!"),
      ));
  }
 // 回退路由栈时返回信息
 RaisedButton(
    onPressed: () {
        Navigator.pop(context, "Opt2");
    },
    child: Text("Option22222"))
```

pop方法内部:

```dart
Navigator.of(context)!.pop<T>(result);
```

4. 接收参数

```dart
ModalRoute.of(context).settings.arguments
```

(MPR继承自PageRoute, PR又继承自ModelRoute类)

5. 路由拦截

## 其他

onUnknownRoute 方法, 在路由未正确注册/构造时触发

initialRoute 属性, 初始界面

onGenerateRoute 接收RouteSettings settings, 可以在这里统一拦截路由, 比如switch(settings.name) case "/" ... case "/home" 啥的.
可以这么用: 动态从routes常量里取路由信息, 所有路由都动态的进行构造, 这么一来前面的接收参数也可以用这种方法, 如

```dart
return MaterialPageRoute(
  builder: (context) {
    return PassArgumentsScreen(
      title: args.title,
      message: args.message,
    );
  },
);
```

路由栈控制:
```dart
// 1-2-3, 直接从3到1
Navigator.popUntil(context, ModalRoute.withName('/page1'));

// 1-2-3, 替换3为4
Navigator.popAndPushNamed(context, '/page4');
Navigator.pushReplacementNamed(context, '/page4');

// 1-2-3 删除记录 只显示1/2
Navigator.pushNamedAndRemoveUntil(context, '/page1', (Route<dynamic> route) => false); // 这种方式是删除所有的路由，/page1页变成最底层的页面，这种方式可以用作返回首页

// 1-2-3 显示4 删除所有记录只保留1
Navigator.pushNamedAndRemoveUntil(context, '/page4', ModalRoute.withName('/page1')); // 从page4返回会回到page1 
```

当前路由控制:

```dart
ModalRoute.of(context)
```

isActive 当前路由是否处于navigator中

isCurrent 当前路由是否为最顶层

isFirst 是否为最底层 为true则Navigator.canPop为false
willHandlePopInternally也为false

maintainState 当路由为inactive状态时是否应当被保存状态

offstage 是否可见

...