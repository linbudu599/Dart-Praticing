# 导航

1. 顶部导航

DefaultTabController + TabBar + TabBarView

如果需要Tab间共享数据, 应该要在外面包个Provider

```dart
    MaterialApp(
        home: DefaultTabController(
            length: choices.length,
            initialIndex: 0,
            child: Scaffold(
                appBar: AppBar(
                    title: const Text("Tabbed AppBar"),
                    bottom: TabBar(
                        isScrollable: true,
                        tabs: choices
                            .map((Choice choice) => Tab(
                                text: choice.title, icon: Icon(choice.icon)))
                            .toList())),
                body: TabBarView(
                  children: choices
                      .map((Choice choice) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ChoiceCard(choice: choice)))
                      .toList(),
                ))))
```

2. 底部导航

PageController + PageView + BottomNavigationBar

注意:

- 需要混入SingleTickerProviderStateMixin类
- 需要在dispose时调用controller实例的dispose方法

```dart
  PageController _controller = PageController(initialPage: 0,keepPage: true);


      PageView(
        pageSnapping: false,
        reverse: false,
        onPageChanged: (int i) {
          print(i);
        },
        controller: _controller,
        children: <Widget>[
          Text("1"),
          Text("2"),
          Text("3"),
          Text("4"),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _idx,
          onTap: (int i) {
            _controller.jumpToPage(i);
            setState(() {
              _idx = i;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _buildItem(Icons.home, "首页", 0),
            _buildItem(Icons.search, "搜索", 1),
            _buildItem(Icons.camera_alt, "旅拍", 2),
            _buildItem(Icons.account_circle, "我的", 3),
          ]),
```

在BotNavBar的点击事件中去做controller跳转(jumpToPage)

3. 侧边

直接使用Scaffold的drawer属性

Draw的children中, DrawHeader是可选的

里面可以用ListTile做菜单项, 但感觉还会有更好看的

不管是用哪个, 能在菜单项的点击事件中传递信息给主页面就行

```dart
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Side Navigation")),
      body: Center(child: Text("Current Chosed $_curr")),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            duration: const Duration(milliseconds: 300),
            child: const Text(
              "Side Menu",
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            )),
        ListTile(
          leading: Icon(Icons.file_download),
          title: Text('Item 1'),
          onTap: () {
            setState(() {
              _curr = "1";
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.file_upload),
          title: Text('Item 2'),
          onTap: () {
            setState(() {
              _curr = "2";
            });
            Navigator.pop(context);
          },
        ),
      ])),
    );
  }
```