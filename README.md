# Dart-Praticing

Learning Dart And Not Just For Flutter🧸.

## Stage

典型结构：

```dar
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello! Flutter~",
        home: Scaffold(
          appBar: AppBartitle: Text("Hello! Head~~~")),
          body: Center(
              child: Container(
                  child: new Image.network(
                    "",
                  ),
                  alignment: Alignment.topCenter,
                  )),
        ));
  }
}
```

很好奇为什么写样式这样写，去源码看了一下原来`Alignment`是个类，`Alignment.topCenter`是其静态属性，但是实质上还是个`Alignment`类。

```dart
static const Alignment topLeft = Alignment(-1.0, -1.0);
```

子类和修饰属性同级，子类内部也是。



## 布局

- Scaffold、AppBar、Container
- ListView（内部使用itemBuilder新建子项，itemCount规定子类数目），内部可用Axis等属性控制方向

- GridView，类似CSS3 Grid布局，也可控制纵向、横向

- CardView，卡片式布局，有点类似ANTD的Card，与ListTile、Divider共用贼好看
- Stack，层叠布局



## 基本使用

### 路由系统及传参

```dart
void main() {
  runApp(MaterialApp(title: "子页面返回数据", home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  // Key 类似于React中的key，是Widget的唯一标识符
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("获取数据"),
          ),
          body: Center(child: RouteButton())),
    );
  }
}

class RouteButton extends StatelessWidget {
  const RouteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () {
          _navigateToXjj(context);
        },
        child: Text("去获取数据~"));
  }
// 理一理：
// 点击跳转前往Xjj组件  点击其中的项后会回退的同时传参
// 返回的时候result就能接收到值
  _navigateToXjj(BuildContext context) async {
      
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Xjj()));

    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
  }
}

class Xjj extends StatelessWidget {
  const Xjj({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("XJJ")),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("1号"),
              onPressed: () {
                Navigator.pop(context, "1haohaohao");
              }),
          RaisedButton(
              child: Text("2号"),
              onPressed: () {
                Navigator.pop(context, "2haohaohao");
              }),
          new Image.asset("assets/11.jpg")
        ],
      )),
    );
  }
}
```

等等突然疑惑Flutter是会自动接收build方法的返回来渲染吗



商品列表demo

```dart
import 'package:flutter/material.dart';

class Product {
  final String title;
  final String desc;
  Product(this.title, this.desc);
}

void main() {
  runApp(MaterialApp(
      title: "导航传参",
      home: ProductList(
          products: List.generate(20, (i) => Product("商品 $i", "第 $i 个商品")))));
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("商品列表")),
          body: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(products[index].title),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(product: products[index])));
                    });
              })),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("商品${product.title}详情")),
          body: Center(
            child: Text('${product.desc}'),
          )),
    );
  }
}
```



注意下几个地方

- push方法的入参，注意还是要从Material提供的构造函数点出来

  ```dart
  Navigator.push(
  				context,
  				MaterialPageRoute(
  					builder: (context) =>
  						ProductDetail(product: products[index])));
  ```

- 子组件接收数据：

  ```dart
  // ProductDetail(product: products[index]))
  class ProductDetail extends StatelessWidget {
    final Product product;
    ProductDetail({Key key, @required this.product}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Scaffold(
            appBar: AppBar(title: Text("商品${product.title}详情")),
            body: Center(
              child: Text('${product.desc}'),
            )),
      );
    }
  }
  ```

  