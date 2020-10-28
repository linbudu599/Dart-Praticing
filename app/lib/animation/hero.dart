import 'package:flutter/material.dart';

// 路由切换时共享的widget动画切换过程
// hero动画也称为共享元素转换
// 原理: Flutter根据tag确定了新旧路由页中共享元素位置与大小 根据端点自动计算中间状态

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: ClipOval(
              child: Image.network(
                  "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
                  width: 50,
                  height: 50)),
        ),
        onTap: () {
          //打开B路由
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
            return new FadeTransition(
              opacity: animation,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("原图"),
                ),
                body: HeroAnimationRouteB(),
              ),
            );
          }));
        },
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.network(
          "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif",
        ),
      ),
    );
  }
}
