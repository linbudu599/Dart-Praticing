import "package:flutter/material.dart";

// 三组生命周期
// 初始化 createState initState
// 更新 didChangeDeps build didUpdateWidget
// 销毁 deactivate dispose
//

class LifeCycle extends StatefulWidget {
  LifeCycle({Key key}) : super(key: key);

  // 立即调用 必须重写
  @override
  _LifeCycleState createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> {
  int count = 0;

  // 创建Widget时调用的除构造方法之外的第一个方法
  // 初始化工作 如channel与监听器初始化
  @override
  void initState() {
    print("Init State");
    super.initState();
  }

  // 在依赖的state对象改变时调用
  // 初次构建widget时在initState后立即调用此方法
  // 依赖于InheritedWidget时, 所依赖的IW数据改变, 也会调用此方法
  @override
  void didChangeDependencies() {
    print("Did Change Dependencies");
    super.didChangeDependencies();
  }

  // 必须实现 在didChange后立即调用
  // 调用setState后也会再次调用
  @override
  Widget build(BuildContext context) {
    print("Build");
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Page LifeCycle"),
            leading: BackButton(),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text(
                    "Click",
                    style: TextStyle(fontSize: 26),
                  ),
                  onPressed: () {
                    setState(() {
                      count += 1;
                    });
                  }),
              Text(count.toString())
            ],
          ))),
    );
  }

  // 父组件需要重绘时才会调用 有点像shouldComponentUpdate
  // oldWidget.xxx 与 currentWidget.xxx 比较这样
  @override
  void didUpdateWidget(LifeCycle oldWidget) {
    print("did Update Widget");
    super.didUpdateWidget(oldWidget);
  }

  // 组件移除前调用 在dispose前调用
  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }
}
