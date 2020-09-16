import "package:flutter/material.dart";

// 应用维度生命周期
// WidgetBindingObserver Widget绑定观察器
// 监听应用生命周期

class AppLifecycle extends StatefulWidget {
  AppLifecycle({Key key}) : super(key: key);

  @override
  _AppLifecycleState createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("应用生命周期"), leading: BackButton()),
      body: Container(
        child: Text("应用维度生命周期"),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state: $state');
    if (state == AppLifecycleState.paused) {
      print("后台");
    } else if (state == AppLifecycleState.resumed) {
      print("前台");
    } else if (state == AppLifecycleState.inactive) {
      // 比如用户接了个电话
      print("非活动状态");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
