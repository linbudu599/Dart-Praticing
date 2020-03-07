import 'package:flutter/material.dart';
import 'Home.dart';

class SplashSreen extends StatefulWidget {
  @override
  _SplashSreenState createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen>
    with SingleTickerProviderStateMixin {
  // 控制时间 效果等
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => route == null);
      }
    });

    // start
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
          "https://avatars3.githubusercontent.com/u/48507806?s=460&v=4",
          scale: 2.0,
          fit: BoxFit.cover),
    );
  }
}
