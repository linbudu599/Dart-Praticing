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

// void main() {
//   runApp(MaterialApp(title: "导航演示", home: new FirstScreen()));
// }

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Router")),
//         body: Center(
//             child: RaisedButton(
//           onPressed: () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => new SecondScreen())),
//           child: Text("查看详情页"),
//         )));
//   }
// }

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Route!Route!")),
//         body: Center(
//             child: RaisedButton(
//           child: Text("返回"),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         )));
//   }
// }
