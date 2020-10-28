# 动画

> 来了老弟

FPS: Frame Per Second

大于16FPS看起来就挺流畅, 大于32FPS看起来就非常平滑

但Flutter中理想情况可以达到60FPS

Flutter中对动画的抽象

- Animation
- Curve
- Controller
- Tween

Animation: 

本身是一个抽象类, 主要功能是保存动画插值状态, Animation对象在一段时间内依次生成一个区间(Tween)之间值, 它在整个动画执行过程中输出的值可以是线下的, 曲线的, 异步的, 具体由Curve决定. Animation还可以控制动画的方向, 甚至在执行过程中改变方向.

其接受的类型参数包括double Color Size.

可以在每一帧中通过Animation.value获取动画当前状态值.

通过Animation还可以监听动画每一帧以及执行状态变化:

- addListener: 添加帧监听器, 会在每一帧都被调用, 最常见的是在改变状态后调用setState触发重建.

- addStatusListener: 给Animation添加状态切换监听器, 开始/结束/正向/反向时均会调用.

Curve:

用于描述动画过程, 匀速/匀加速/变速, 只有匀速动画被称为线性动画(Curve.linear), 通过CurvedAnimation指定动画曲线:

```dart
final CurvedAnimation curve =
    new CurvedAnimation(parent: controller, curve: Curves.easeIn);
```

CurvedAnimation和AnimationController（下面介绍）都是`Animation<double>`类型:

- CA通过包装AnimationController和Curve生成一个新的动画对象, 使用这种方式关联动画与动画执行曲线

Curves:

- linear 匀速
- decelerate 匀减速
- ease 加速后减速
- easeIn 先慢后快
- easeOut 先快后慢
- easeInOut 慢 加速 减速
- ...

创建自定义曲线:

```dart
class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(t * math.PI * 2);
  }
}
```

AnimationController:

控制动画, 包括forward启动/stop停止/反向reverse等

会在动画的每一帧生成一个新的值, 默认在给定时间段内线性生成0.0-1.0的数字:

```dart
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 2000), vsync: this);

// 指定生成数字区间
final AnimationController controller = new AnimationController( 
 duration: const Duration(milliseconds: 2000), 
 lowerBound: 10.0,
 upperBound: 20.0,
 vsync: this
);
```


动画开始执行后会生成动画帧, 每刷新一次就是一个动画帧, 每一帧会根据当前动画曲线生成当前动画值(即Animation.value), 再根据当前动画值构建UI, 在动画的每一帧, 帧监听器会被调用

> 通过duration来控制动画执行时长, 即动画速度.

某些情况下动画值会超出区间, 如fling函数可以根据手指滑动模拟一个甩出动画, Curves.elasticIn等弹性曲线也会有此效果

Ticker:

AC的vsync参数接收一个TickerProvider类型对象, 主要职责是创建一个Ticker, 定义:

```dart
abstract class TickerProvider {
  //通过一个回调创建一个Ticker
  Ticker createTicker(TickerCallback onTick);
}
```

Flutter应用启动时会绑定一个SchedulerBinding, 通过SB可以为每一次屏幕刷新添加回调, Ticker即是通过SB添加回调的, 使得每一次屏幕刷新都会调用TickerCallback.

使用Ticker来驱动动画而非Timer, 能够防止屏幕外动画(如锁屏等情况)消耗资源, Flutter中屏幕刷新会通知绑定的SB, 然后才会驱动Ticker, 所以在屏幕不刷新的情况下不会触发Ticker

> 通常会将SingleTickerProviderStateMixin添加到State, 然后将State对象作为vsync值

Tween:

默认情况下区间是0.0-1.0, 但有时需要负责构建UI的动画值在不同范围或者是不同类型(double - Color), 就需要Tween来添加映射:

生成-200-0

```dart
final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
```

Tween继承自Animatable而非Animation, 其中主要定义动画映射规则

```dart
final Tween colorTween =
    new ColorTween(begin: Colors.transparent, end: Colors.black54);
```

Tween不存储任何状态, 但可以获取动画当前映射值(evaluate方法), Animation当前值还是可以通过value获取, evaluate还会确保在开始和结束区间处理状态

使用: animate方法

```dart
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(controller);
// 返回一个Animation而非Animatable
```

```dart
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
final Animation curve =
    new CurvedAnimation(parent: controller, curve: Curves.easeOut);
Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(curve);
```

## 路由动画

MaterialPageRoute会自动使用平台风格的路由切换动画, 如IOS左右滑动, 安卓上下滑动

在安卓上使用左右:

```dart
 Navigator.push(context, CupertinoPageRoute(  
   builder: (context)=>PageB(),
 ));
```

路由切换动画:

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return new FadeTransition(
        //使用渐隐渐入过渡,
        opacity: animation,
        child: PageB(), //路由B
      );
    },
  ),
);
```

MaterialPageRoute、CupertinoPageRoute，PageRouteBuilder都继承自PageRoute类，而PageRouteBuilder其实只是PageRoute的一个包装

直接继承PageRoute来实现自定义路由:

```dart
class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) => builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
     return FadeTransition( 
       opacity: animation,
       child: builder(context),
     );
  }
}

Navigator.push(context, FadeRoute(builder: (context) {
  return PageB();
}));
```

大部分场景下应使用PageRouteBuilder, 但有些场景下应用切换动画时需要读取当前路由属性, 如只在打开路由时应用动画:

```dart
@override
Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
 //当前路由被激活，是打开新路由
 if(isActive) {
   return FadeTransition(
     opacity: animation,
     child: builder(context),
   );
 }else{
   //是返回，则不应用过渡动画
   return Padding(padding: EdgeInsets.zero);
 }
}
```

## AnimatedSwitcher 原理

在didUpdateWidget中判断新旧child是否发生变化
对旧child执行反向退场 对新child执行正向入场

```dart
Widget _widget; //
void didUpdateWidget(AnimatedSwitcher oldWidget) {
  super.didUpdateWidget(oldWidget);
  // 检查新旧child是否发生变化(key和类型同时相等则返回true，认为没变化)
  if (Widget.canUpdate(widget.child, oldWidget.child)) {
    // child没变化，...
  } else {
    //child发生了变化，构建一个Stack来分别给新旧child执行动画
   _widget= Stack(
      alignment: Alignment.center,
      children:[
        //旧child应用FadeTransition
        FadeTransition(
         opacity: _controllerOldAnimation,
         child : oldWidget.child,
        ),
        //新child应用FadeTransition
        FadeTransition(
         opacity: _controllerNewAnimation,
         child : widget.child,
        ),
      ]
    );
    // 给旧child执行反向退场动画
    _controllerOldAnimation.reverse();
    //给新child执行正向入场动画
    _controllerNewAnimation.forward();
  }
}

//build方法
Widget build(BuildContext context){
  return _widget;
}
```