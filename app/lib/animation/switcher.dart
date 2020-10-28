import "package:flutter/material.dart";

// AnimatedSwitcher 用于同时对新旧子元素添加显示隐藏动画
// const AnimatedSwitcher({
//   Key key,
//   this.child,
//   @required this.duration, // 新child显示动画时长
//   this.reverseDuration,// 旧child隐藏的动画时长
//   this.switchInCurve = Curves.linear, // 新child显示的动画曲线
//   this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
//   this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
//   this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
// })

// child发生变化时 旧child执行隐藏 新child执行显示 具体效果由transitionBuilder决定
// typedef AnimatedSwitcherTransitionBuilder =
//   Widget Function(Widget child, Animation<double> animation);
// 对旧child执行反向动画 对新的执行正向动画
// 默认执行渐隐渐显
// Widget defaultTransitionBuilder(Widget child, Animation<double> animation) {
//   return FadeTransition(
//     opacity: animation,
//     child: child,
//   );
// }

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            // 新旧child如何类型不同 key必须不同
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              // return ScaleTransition(child: child, scale: animation);
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              // return MySlideTransition(
              //   child: child,
              //   position: tween.animate(animation),
              // );
              return SlideTransitionX(
                child: child,
                direction: AxisDirection.down, //上入下出
                position: animation,
              );
            },
            child: Text(
              '$_count',
              //显式指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          RaisedButton(
            child: const Text(
              '+1',
            ),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

// 路由平移切换 旧页面向左推出 新页面从右进入
// 直接使用的效果: 旧页面右侧退出
// 需要打破对称性
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

// 封装来实现其他效果 如上入下出
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
