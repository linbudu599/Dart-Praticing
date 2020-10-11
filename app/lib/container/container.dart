import 'package:flutter/material.dart';

class ContainerCollection extends StatelessWidget {
  const ContainerCollection({Key key}) : super(key: key);

  Widget _text(String text) => Text(text,
      style: TextStyle(backgroundColor: Colors.black87, color: Colors.white));

  Widget _redBox() => DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("容器组件"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: _text("Padding"),
            ),
            ConstrainedBox(
              // 或使用这种方法快速构造尺寸限制
              // BoxConstraints.tight(Size.square(20))
              constraints: BoxConstraints(
                  // 包括最小/最大 宽高
                  minWidth: double.infinity, //宽度尽可能大
                  minHeight: 50.0 //最小高度为50像素
                  ),
              //
              child: Container(height: 5.0, child: _redBox()),
            ),
            SizedBox(width: 80.0, height: 80.0, child: _redBox()),
            Container(
              height: 100,
              width: 100,
              child: FractionallySizedBox(
                child: _redBox(),
                widthFactor: 0.5,
                heightFactor: 0.5,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("wuhu1!");
              },
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange[700]]), //背景渐变
                      borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      boxShadow: [
                        //阴影
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0)
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
