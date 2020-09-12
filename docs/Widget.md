# 基本 Widget

- Text 文本控件,几乎都是使用这个控件来展示文字.如:

  ```dart
  appBar: AppBar(title: Text("一些文本"))
  ```

- Row 与 Column 弹性布局控件,类似 Flex 布局,分别负责水平和垂直方向.

- Stack 层叠布局控件, 允许子控件堆叠, 内部使用`Positioned`控件定位位置, 类似于绝对定位.

- Container 矩形控件, 我个人觉得类似 React 的`<></>`或者 Vue 的`<template></template>`. 但是不确定会不会被 Skia 也渲染上去.
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

  不同控件的样式写法也不同? `Text`需要 style 属性+`TextStyle()`, 而`Container`需要`decoration`+`new BoxDecoration()`, 而且, 有一部分样式是独立的如内外间距/宽高等.

- Card 卡片式布局, 内部可以再用 Row/Column 对子元素布局, 感觉配合`ListTile`整挺好.

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

  (感觉和`Card`的主要区别场景是每一行的元素个数? 仅为一个的时候用 Card 省心点?)

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

- ImgView 图片控件,需要区分本地资源与网络图片, 即`Image.asset`与`Image.netWork`

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

  有点像 React 中 map 生成列表项~

- Scaffold, Material Design 布局结构的基本实现, 也就是说内部的元素会在符合 Material 规范的位置上. 内部又有一大大大大堆控件.

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

- BottomNavigationBar 与 BottomNavigationBarItem, 底部导航栏控件,这里每个导航栏的`onTap`事件是被整个 BottomNavigationBar 控件代理的,如:

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

  在其中可以绑定`onTap`事件, 疑惑, 不能每个 Item 自己一个吗, 一定要用 index 标识?

- 底部工具栏与嵌入式按钮, 注意`StatefulWidget`的使用

  ```dart
  // dynamic.dart, 动态视图控件
  class DynamicView extends StatefulWidget {
    String _title;
    DynamicView(this._title);
    // 重写原先的自定义状态方法
    @override
    _DynamicViewState createState() => _DynamicViewState();
  }

  // 注意extends State<DynamicView>这个写法, 似乎是抽离状态生成类的必须步骤
  class _DynamicViewState extends State<DynamicView> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text(widget._title)),
          body: Center(child: Text(widget._title)));
    }
  }

  //bottomApp.dart, 工具栏控件
  class BottomBar extends StatefulWidget {
    @override
    _BottomBarState createState() => _BottomBarState();
  }

  class _BottomBarState extends State<BottomBar> {
    List<Widget> views;
    int _idx = 0;

    @override
    // 和createState()的区别是?
    void initState() {
      super.initState();
      views = List();
      // 添加视图到初始属性
      views..add(DynamicView("Home"))..add(DynamicView("Other"));
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: views[_idx],
        ),
        // 交互用的浮动按钮
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
                  // 导航变化同时生成视图
              return DynamicView("New Page");
            }));
          },
          tooltip: "长按才会显示",
          // 按钮图标
          child: Icon(Icons.add, color: Colors.white),
        ),
        // 为啥是独立出来的...
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // 底部导航栏
        bottomNavigationBar: BottomAppBar(
            color: Colors.deepOrange,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.scanner, color: Colors.lightBlueAccent),
                    onPressed: () {
                      setState(() {
                        _idx = 0;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.dashboard, color: Colors.lightBlueAccent),
                    onPressed: () {
                      setState(() {
                        _idx = 1;
                      });
                    })
              ],
            )),
      );
    }
  }

  ```

- ExpansionTile 与 ExpansionPanelList, 展开闭合效果

  ```dart
  // 单个展开闭合组件
  class ExpansionTileDemo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text("展开")),
          body: Center(
              child: ExpansionTile(
            title: Text("Expansion Tile"),
            leading: Icon(Icons.data_usage),
            backgroundColor: Colors.white12,
            children: <Widget>[
              ListTile(
                title: Text("Item"),
                subtitle: Text("Sub Title"),
              )
            ],
            initiallyExpanded: true,
          )));
    }
  }

  // 展开闭合列表
  class ExpansionPanelListDemo extends StatefulWidget {
    @override
    _ExpansionPanelListDemoState createState() => _ExpansionPanelListDemoState();
  }

  class _ExpansionPanelListDemoState extends State<ExpansionPanelListDemo> {
    int currentPanelIndex = -1;
    List<int> mList; //组成一个int类型数组，用来控制索引
    List<ExpandStateBean> expandStateList; // 用于状态控制
    // 与类同名的函数即为构造函数, 会在调用这个类时自动被调用, 但最后结果还是build方法的?
    _ExpansionPanelListDemoState() {
      mList = new List();
      expandStateList = new List();
      //便利为两个List进行赋值
      for (int i = 0; i < 10; i++) {
        mList.add(i);
        // 初始状态全为关闭
        expandStateList.add(ExpandStateBean(i, false));
      }
    }
    //切换展开/闭合
    _setCurrentIndex(int index, isExpand) {
      setState(() {
        //遍历可展开状态列表
        expandStateList.forEach((item) {
          if (item.index == index) {
            //取反，经典取反方法
            item.isOpen = !isExpand;
          }
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text("expansion panel list")),
          //加入可滚动组件
          body: SingleChildScrollView(
            child: ExpansionPanelList(
              // 点击某项时触发
              expansionCallback: (index, bol) {
                _setCurrentIndex(index, bol);
              },
              children: mList.map((index) {
                //进行map操作，然后用toList再次组成List
                return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(title: Text('This is No. $index'));
                    },
                    body: ListTile(title: Text('Expansion no.$index')),
                    isExpanded: expandStateList[index].isOpen);
              }).toList(),
            ),
          ));
    }
  }

  //自定义扩展状态类
  class ExpandStateBean {
    var isOpen;
    var index;
    ExpandStateBean(this.index, this.isOpen);
  }
  ```

- 接近原生效果的搜索栏, 带提示&交互

  ```dart
  // tip.dart, 结果与提示mock
  const searchList = <String>[
    "res1",
    "res2",
    "res3",
    "res4",
  ];

  const suggest = <String>["tip1", "tip2", "tip3", "tip4"];

  // search.dart 搜索主控件
  class SearchBar extends StatefulWidget {
    @override
    _SearchBarState createState() => _SearchBarState();
  }

  class _SearchBarState extends State<SearchBar> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("搜索！"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // print("Clicked!");
                  showSearch(context: context, delegate: SearchBarDelegate());
                }),
          ],
        ),
      );
    }
  }

  // 继承这个类并重写其中方法
  class SearchBarDelegate extends SearchDelegate<String> {
    @override
    // 搜索框右侧的执行方法(如清空)
    List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = "",
        )
      ];
    }

    // 左侧, 如收起搜索框
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
          icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
          onPressed: () => close(context, null));
    }

    @override
    Widget buildResults(BuildContext context) {
      return Container(
        width: 100.0,
        height: 100.0,
        child: Card(
          color: Colors.redAccent,
          child: Text(query),
        ),
      );
    }

    // 搜索联想
    @override
    Widget buildSuggestions(BuildContext context) {
      final suggestionList = query.isEmpty
          ? suggest
          : searchList.where((input) => input.startsWith(query)).toList();

      return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
            title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]))),
      );
    }
  }

  ```

- Wrap 流式布局 与是手势控件

  ```dart
  class Wrapper extends StatefulWidget {
    @override
    _WrapperState createState() => _WrapperState();
  }

  class _WrapperState extends State<Wrapper> {
    List<Widget> list;

    @override
    void initState() {
      super.initState();
      list = List<Widget>()..add(buildAppButton());
    }

    @override
    Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      return Scaffold(
          appBar: AppBar(title: Text("Wrap~")),
          body: Center(
              child: Opacity(
            opacity: 0.8,
            child: Container(
                width: width,
                height: height / 2,
                color: Colors.grey,
                child: Wrap(
                  children: list,
                  spacing: 26,
                )),
          )));
    }

    Widget buildAppButton() {
      // 使container具有交互能力
      // 这个控件只是用来触发手势操作的事件
      return GestureDetector(
        onTap: () {
          // 当没有达到数量 点击会添加容器
          if (list.length < 9) {
            setState(() {
              list.insert(list.length - 1, buildPhoto());
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(color: Colors.black54, child: Icon(Icons.add)),
        ),
      );
    }

    Widget buildPhoto() {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 80.0,
            color: Colors.orangeAccent,
            child: Center(child: Text("照片!")),
          ));
    }
  }

  ```

- 保持页面状态(Keep Alive)

  ```dart
  // with关键字允许将多个类功能添加到自己的类而无需继承它们, 避免多重继承的覆盖等问题.
  // main.dart
  class KeepAliveDemo extends StatefulWidget {
    KeepAliveDemo({Key key}) : super(key: key);

    @override
    _KeepAliveDemoState createState() => _KeepAliveDemoState();
  }

  class _KeepAliveDemoState extends State<KeepAliveDemo>
      with SingleTickerProviderStateMixin {

    TabController _controller;

    @override
    void initState() {
      super.initState();
      // 来自于上面的混入类
      _controller = TabController(length: 3, vsync: this);
    }

    // 重写释放方法, 这里只释放TabController
    @override
    void dispose() {
      _controller.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Keep Alive"),
            bottom: TabBar(
              controller: _controller,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.add_to_photos)),
                Tab(icon: Icon(Icons.delete)),
                Tab(icon: Icon(Icons.gamepad))
              ],
            ),
          ),
          // 独立的Tab页面
          body: TabBarView(
              controller: _controller,
              children: <Widget>[Home(), Home(), Home()]));
    }
  }

  // home.dart
  class Home extends StatefulWidget {
    Home({Key key}) : super(key: key);

    @override
    _HomeState createState() => _HomeState();
  }

  // AutomaticKeepAliveClientMixin类是保持状态的关键
  class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
    int _counter = 0;

    @override
    // 混入了上面的类后必须重写此方法, 来开启记忆功能
    bool get wantKeepAlive => true;

    void _incrementCounter() {
      setState(() {
        _counter++;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("点击加1"),
              Text(
                "$_counter",
                style: Theme.of(context).textTheme.display1,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Incr",
          child: Icon(Icons.add),
        ),
      );
    }
  }

  ```

- 右滑返回上一页(Cupertino UI)

  ```dart
  import 'package:flutter/cupertino.dart';

  class RightBackDemo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        child: Center(
          child: Container(
            height: 100.0,
            width:100.0,
            color: CupertinoColors.activeBlue,
            child: CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: (){
                Navigator.of(context).push(
                  // 只要使用CupertinoPageRoute打开的子页面，就可以实现右滑返回上一级
                  CupertinoPageRoute(builder: (BuildContext context){
                    return RightBackDemo();
                  })
                );
              },
            ),
          ),
        ),
      );
    }
  }
  ```

- 拖拽 控件

  ![preview](http://blogimages.jspang.com/FlutterDemo18.gif)

  ```dart
  // 基本控件
  Draggable(
    // 被拖拽元素会接收的参数
    data: widget.widgetColor,
    child: Container(
      width: 100,
      height: 100,
      color: widget.widgetColor,
    ),
    // 拖拽元素的样式(交互反馈)
    feedback:Container(
      width: 100.0,
      height: 100.0,
      color: widget.widgetColor.withOpacity(0.5),
    ),
    // 松开时的事件, 常用于改变拖拽落地位置
    onDraggableCanceled: (Velocity velocity, Offset offset){
      setState(() {
        this.offset = offset;
      });
    }


  class DraggableDemo extends StatefulWidget {
    @override
    _DraggableDemoState createState() => _DraggableDemoState();
  }

  class _DraggableDemoState extends State<DraggableDemo> {
    Color _draggableColor = Colors.grey;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Stack(
        children: <Widget>[
          DraggableWidget(
            offset: Offset(80.0, 80.0),
            widgetColor: Colors.tealAccent,
          ),
          DraggableWidget(
            offset: Offset(180.0, 80.0),
            widgetColor: Colors.redAccent,
          ),
          Center(
            child: DragTarget(onAccept: (Color color) {
              _draggableColor = color;
            }, builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200.0,
                height: 200.0,
                color: _draggableColor,
              );
            }),
          )
        ],
      ));
    }
  }

  class DraggableWidget extends StatefulWidget {
    final Offset offset;
    final Color widgetColor;
    const DraggableWidget({Key key, this.offset, this.widgetColor}):super(key:key);
    _DraggableWidgetState createState() => _DraggableWidgetState();
  }

  class _DraggableWidgetState extends State<DraggableWidget> {
    Offset offset = Offset(0.0,0.0);
    @override
    void initState() {
      super.initState();
      offset = widget.offset;
    }

    @override
    Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top:offset.dy,
      child: Draggable(
        data:widget.widgetColor,
        child: Container(
          width: 100,
          height: 100,
          color:widget.widgetColor,
        ),
        feedback:Container(
          width: 100.0,
          height: 100.0,
          color: widget.widgetColor.withOpacity(0.5),
        ),
        onDraggableCanceled: (Velocity velocity, Offset offset){
          setState(() {
              this.offset = offset;
          });
        },
      ),
    );
    }
  }
  ```
