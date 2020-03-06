# Flutter-Praticing

Learning Dart And Flutter🧸.

## 当前进度

- 还在适应语法和熟悉API..

## 基本Widget

> [Dart学习笔记](demo/)

- Text 文本控件,几乎都是使用这个控件来展示文字.如:
  
  ```dart
  appBar: AppBar(title: Text("一些文本"))
  ```

- Row 与 Column 弹性布局控件,类似Flex布局,分别负责水平和垂直方向.

- Stack 层叠布局控件, 允许子控件堆叠, 内部使用`Positioned`控件定位位置, 类似于绝对定位.

- Container 矩形控件, 我个人觉得类似React的`<></>`或者Vue的`<template></template>`. 但是不确定会不会被Skia也渲染上去.
`decoration: new BoxDecoration(color: Colors.blue[500])`,内部装饰盒模型.

- Card 卡片式布局, 内部可以再用Row/Column对子元素布局, 感觉配合`ListTile`整挺好.

- GridView, 网格布局控件,类似于`Grid`布局,内部设置横/纵轴对齐,元素间距,宽高比,等等.

- ImgView 图片控件,需要区分本地资源与网络图片.

- ListView 列表布局控件, 使用方式如:
  
  ```dart
  new ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => new ListTile(
      title: new Text("Item $index -> $context = ${items[index]}")),
          )
  ```
  
  有点像map~

  还有普通的使用方式:

  ```dart
  new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 100.0,
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(10.0),
        ),
        new Container(
          width: 100.0,
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(10.0),
        ),
      ],
    );
  ```

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

  同样有好多控件...,有生之年系列.

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

- 底部工具栏+嵌入式按钮,参见[demo](./flutter-demo/util/bottomToolBar)

- 展开效果,参见[demo](./flutter-demo/util/Expansion)

- 接近原生效果的搜索栏,参见[demo](./flutter-demo/util/SearchBar)

- Wrap 流式布局, 比较简单(目前接触的),设置`children`和`spacing`等属性在内部进行排版.

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

> emm懵懵懂懂

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