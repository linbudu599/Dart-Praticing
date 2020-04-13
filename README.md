# Flutter-Praticing

Learning Dart And Flutter🧸.

## 当前进度

> [Dart学习demo](demo/)

- 熟悉Flutter常用Widget中
- 界面基本功能(路由/交互/动画/网络请求/优化...), 梦回初学前端

## 基本Widget

- Text 文本控件,几乎都是使用这个控件来展示文字.如:
  
  ```dart
  appBar: AppBar(title: Text("一些文本"))
  ```

- Row 与 Column 弹性布局控件,类似Flex布局,分别负责水平和垂直方向.

- Stack 层叠布局控件, 允许子控件堆叠, 内部使用`Positioned`控件定位位置, 类似于绝对定位.

- Container 矩形控件, 我个人觉得类似React的`<></>`或者Vue的`<template></template>`. 但是不确定会不会被Skia也渲染上去.
`decoration: new BoxDecoration(color: Colors.blue[500])`,内部装饰盒模型.

举例:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello! Flutter~",
        home: Scaffold(
          appBar: AppBar(title: Text("Hello! Head~~~")),
          body: Center(
              child: Container(
                   child: Text(
                    "Hello!",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Color.fromARGB(255, 255, 112, 123),
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid),
                   ),
                  // 内部子类对齐方式
                  alignment: Alignment.topCenter,
                  width: 1000.0,
                  height: 1000.0,
                  <!-- // color: Colors.lightBlueAccent, -->
                  padding: const EdgeInsets.fromLTRB(50.0, 50.0, 10, 0.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.lightBlue, Colors.greenAccent]),
                      border: Border.all(width: 5.0, color: Colors.black)))),
        ));
  }
}
```

不同控件的样式写法也不同? `Text`需要style属性+`TextStyle()`, 而`Container`需要`decoration`+`new BoxDecoration()`, 而且, 有一部分样式是独立的如内外间距/宽高等. 

- Card 卡片式布局, 内部可以再用Row/Column对子元素布局, 感觉配合`ListTile`整挺好.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = new Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text("111111", style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
              Text("22222", style: TextStyle(fontWeight: FontWeight.w400)),
          leading: new Icon(Icons.add_alert, color: Colors.lightBlueAccent),
        ),
        new Divider(
          thickness: 10.0,
          height: 10.0,
        ),
        // ...repeat ListTile
      ],
    ));

    return MaterialApp(
      title: 'Flutter Demo Row Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: new AppBar(title: new Text("卡片式布局！")),
          body: Center(child: card)),
    );
  }
}
```

- GridView, 网格布局控件,类似于`Grid`布局,内部设置横/纵轴对齐,元素间距,宽高比,等等.

(感觉和`Card`的主要区别场景是每一行的元素个数? 仅为一个的时候用Card省心点?)

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello! Flutter~",
      home: Scaffold(
          appBar: new AppBar(title: new Text("Hello")),
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
              // ... repeat img
            ],
          )),
    );
  }
}
```

- ImgView 图片控件,需要区分本地资源与网络图片.

- ListView 列表布局控件, 使用方式举例:
  
```dart
void main() => runApp(MyApp(items: new List<int>.generate(100, (i) => i)));

class MyApp extends StatelessWidget {
  final List<int> items;

  // 接收参数?
  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello! Flutter~",
      home: Scaffold(
          appBar: new AppBar(title: new Text("Hello")),
          // body: Center(child: Container(height: 200.0, child: MyList())),
          body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => new ListTile(
                title: new Text("Item $index -> $context = ${items[index]}")),
          )),
    );
  }
}

// 或者将生成过程独立出来
class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 100.0,
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(10.0),
        ),
        // repeat
      ],
    );
  }
}
```
  
有点像React中map生成列表项~

- Scaffold, Material Design布局结构的基本实现, 也就是说内部的元素会在符合Material规范的位置上. 内部又有一大大大大堆控件.

- MaterialApp, 内部封装了一些常用的控件,和上面的那家伙不同,通常是这样的:
  
  ```dart
  return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: new AppBar(title: new Text("")),
          body: Center(child: stack)),
    );
  ```

  同样有好多控件..., 有生之年系列.

- BottomNavigationBar 与 BottomNavigationBarItem, 底部导航栏控件,这里每个导航栏的`onTap`事件是被整个BottomNavigationBar控件代理的,如:
  
  ```dart
  return Scaffold(
      body: list[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _navColor),
            title: Text("Home", style: TextStyle(color: _navColor)),
          ),
          // ... more items
        ],
        currentIndex: _currentIdx,
        onTap: (int index) {
          setState(() {
            _currentIdx = index;
          });
        },
      ),
    );
  ```

  在其中可以绑定`onTap`事件, 疑惑, 不能每个Item自己一个吗, 一定要用index标识?

- 底部工具栏+嵌入式按钮,参见[demo](./flutter-demo/util/bottomToolBar)

- 展开效果,参见[demo](./flutter-demo/util/Expansion)

- 接近原生效果的搜索栏,参见[demo](./flutter-demo/util/SearchBar)

- Wrap 流式布局, 比较简单(目前接触的),设置`children`和`spacing`等属性在内部进行排版.

- ...

## 基础知识

- 状态Widget

类似于React中的函数式组件与类组件概念, `statelessWidget`和`stateFulWidget`的初始典型结构如下

```dart
// 有状态
class name extends StatefulWidget {
  name({Key key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}

// 无状态
class name extends StatelessWidget {
  const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
```

`@override`标识符通常表示这个方法重写了父类方法.适用场景不止包括`build()` 方法. 目前还遇到过:
    - createState()
    - initState()
    - dispose()
    - buildActions()
    - buildLeading()
    - buildResults()
    - buildSuggestions()

- 路由及传参

> 懵 懵 懂 懂

通常使用`RaisedButton`,在其`onPressed`事件里调用`Navigator`,使用`.push`(入参context与跳转函数)和`.pop`跳转

```dart
final result = await Navigator.push(
    context, MaterialPageRoute(builder: (context) => NextPage()));
```

路由传参:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context)=>new ProductDetail(product:products[index])
  )
);
```

子页面接收:

```dart
class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key ,@required this.product}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title:Text('${product.title}'),
      ),
      body:Center(child: Text('${product.description}'),)
    );
  }
}
```

页面返回上一级并携带数据:

```dart
  _navigateToNextPage(BuildContext context) async{ 

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> NextPage())
      );

      Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));
  }

  class NextPage extends StatelessWidget {
  const NextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NextPage")),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("1"),
              onPressed: () {
                Navigator.pop(context, "1haohaohao");
              }),
          RaisedButton(
              child: Text("2"),
              onPressed: () {
                Navigator.pop(context, "2haohaohao");
              }),
        ],
      )),
    );
  }
}

```