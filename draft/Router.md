# 路由

一个简单的传参路由demo

```dart
// 首先 生成占位列表数据并传入到控件ProductList
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
  // 接收参数需要两步, 声明参数变量与使用参数变量的构造函数
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
                    // 为每一个列表项绑定点击事件
                    onTap: () {
                      // 路由栈入栈的典型使用方式
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

// 接收路由跳转时的参数并对应的得到新页面
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

`route`是单页或单屏的抽象, 可以有多个. `Navigator`是负责管理`route`的控件(类似history对象), 全局唯一(我的理解, 否则可能会造成页面栈混乱?). 在这个例子里跳转到新页面的方式是调用一个新的类来绘制, 暂不清楚是否有缓存机制, 这种模式和前端的SPA跳转有异有同, 值得体验下不同的思考模式.

另外一个路由传参的例子(上面是前往时带去数据, 这个是回退时带去数据):

```dart
void main() {
  runApp(MaterialApp(title: "子页面返回数据", home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("获取数据"),
          ),
          // 主页面
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
          // 将跳转方法抽离出时记得将context作为入参
          _navigateToXjj(context);
        },
        child: Text("去获取数据~"));
  }

  // async位置
  _navigateToXjj(BuildContext context) async {
    // 这个异步结果等到前往新页面点击完按钮后(路由回退)才会执行
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Xjj()));

    // 我的理解是调用属于当前上下文的Scaffold, 因为可能有多个Scaffold
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