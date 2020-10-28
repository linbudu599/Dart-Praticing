import "package:flutter/material.dart";
import "hero.dart";
import "stagger.dart";
import 'switcher.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();

    // vsync传入this
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    // 添加曲线 也添加在animation 自动重载?
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    // 动画值(映射图片宽高)从0变到300
    // 为animate传入controller 返回一个Animation对象
    // 使用弹性曲线 传入包装过的animation
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    // 经过AW包装后就不需要每次调用setState
    // ..addListener(() {
    //   // setState会使得当前真被标记为脏 重新调用build方法
    //   setState(() => {});
    // });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.network(
    //       "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
    //       width: animation.value,
    //       height: animation.value),
    // );
    // return AnimatedImage(animation: animation);
    // 多动画下再次实现AnimatedWidget不优雅 使用AnimatedBuilder分离渲染逻辑
    // return AnimatedBuilder(
    //   animation: animation,
    //   // 外部child会被再次传递给匿名构造器
    //   child: Image.network(
    //       "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
    //       width: animation.value,
    //       height: animation.value),
    //   // 缩小了重构建范围 现在setState只会导致动画Widget自身重构建
    //   builder: (BuildContext ctx, Widget child) {
    //     return Center(
    //       child: Container(
    //         height: animation.value,
    //         width: animation.value,
    //         child: child,
    //       ),
    //     );
    //   },
    // );
    return GrowTransition(
        child: Image.network(
            "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
            width: animation.value,
            height: animation.value),
        animation: animation);
  }

  dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

// 封装效果来复用动画
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}

// 使用AW类 内部封装了调用setState细节
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.network(
          "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
          width: animation.value,
          height: animation.value),
    );
  }
}

class AnimationDemo extends StatelessWidget {
  const AnimationDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Animation Demo")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                // ScaleAnimationRoute(),
                HeroAnimationRoute(),
                StaggerRoute(),
                AnimatedSwitcherCounterRoute()
              ],
            ),
          ),
        ));
  }
}
