import "package:flutter/material.dart";

/**
 * 通知
 * 每一个节点都可以分发通知 并沿着节点树向上传递
 * 父节点通过NL监听通知 这一行为称为通知冒泡 
 * 与原始指针事件不同的是 这是可以中断的
 */

class NotificationDemo extends StatelessWidget {
  const NotificationDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[NotificationRoute()],
        ),
      ),
    );
  }
}

class ScrollListDemo extends StatelessWidget {
  const ScrollListDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 属于stateless 因此可以放置在任何位置
    // 可以接收一个泛型 必须继承自Notification
    // 显式指定后 NL只会接收该参数类型通知
    // NotificationListener<ScrollEndNotification>(
    //   onNotification: (notification){
    //     //只会在滚动结束时才会触发此回调
    //     print(notification);
    //   },
    //   child: ListView.builder(
    //       itemCount: 100,
    //       itemBuilder: (context, index) {
    //         return ListTile(title: Text("$index"),);
    //       }
    //   ),
    // );
    return NotificationListener(
      onNotification: (Notification notification) {
        // 以下case均继承自ScrollNotification
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            print("开始滚动");
            break;
          // 拥有scrollDelta属性记录位移
          case ScrollUpdateNotification:
            print("正在滚动");
            break;
          case ScrollEndNotification:
            print("滚动停止");
            break;
          case OverscrollNotification:
            print("滚动到边界");
            break;
        }
        // 返回true时会阻止冒泡
        return true;
      },
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          }),
    );
  }
}

class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // RaisedButton(
            // onPressed: () => MyNotification("Hi").dispatch(context),
            // child: Text("Send Notification"),
            // ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
