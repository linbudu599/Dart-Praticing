import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello! Flutter~",
      home: Scaffold(
          appBar: new AppBar(title: new Text("Hello")),
          // body: GridView.count(
          //   padding: const EdgeInsets.all(10.0),
          //   crossAxisSpacing: 10.0,
          //   crossAxisCount: 3,
          //   children: <Widget>[
          //     const Text("Hello1!"),
          //     const Text("Hello2!"),
          //     const Text("Hello3!"),
          //     const Text("Hello4!"),
          //     const Text("Hello5!")
          //   ],
          // )

          body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // 纵轴
              mainAxisSpacing: 2.0,
              // 横轴
              crossAxisSpacing: 4.0,
              // 子元素宽高比
              childAspectRatio: 1.0,
            ),
            children: <Widget>[
              new Image.network(
                "https://pics3.baidu.com/feed/a1ec08fa513d2697215ff693f0dcf8fd4216d81a.jpeg?token=396029c75b06ffda56266a0b87b0fab7&s=0BA3AE0BC48D48EE3C54B4F10300E0B6",
                fit: BoxFit.cover,
              ),
              new Image.network(
                "https://pics3.baidu.com/feed/a1ec08fa513d2697215ff693f0dcf8fd4216d81a.jpeg?token=396029c75b06ffda56266a0b87b0fab7&s=0BA3AE0BC48D48EE3C54B4F10300E0B6",
                fit: BoxFit.cover,
              ),
              new Image.network(
                "https://pics3.baidu.com/feed/a1ec08fa513d2697215ff693f0dcf8fd4216d81a.jpeg?token=396029c75b06ffda56266a0b87b0fab7&s=0BA3AE0BC48D48EE3C54B4F10300E0B6",
                fit: BoxFit.cover,
              ),
              new Image.network(
                "https://pics3.baidu.com/feed/a1ec08fa513d2697215ff693f0dcf8fd4216d81a.jpeg?token=396029c75b06ffda56266a0b87b0fab7&s=0BA3AE0BC48D48EE3C54B4F10300E0B6",
                fit: BoxFit.cover,
              ),
              new Image.network(
                "https://pics3.baidu.com/feed/a1ec08fa513d2697215ff693f0dcf8fd4216d81a.jpeg?token=396029c75b06ffda56266a0b87b0fab7&s=0BA3AE0BC48D48EE3C54B4F10300E0B6",
                fit: BoxFit.cover,
              ),
            ],
          )),
    );
  }
}
