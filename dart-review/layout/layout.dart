import "package:flutter/material.dart";

class Layout extends StatefulWidget {
  Layout({Key key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Layout",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(title: Text("Layout")),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIdx,
              onTap: (int i) {
                setState(() {
                  _currentIdx = i;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.grey),
                    activeIcon: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    title: Text("首页")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit, color: Colors.grey),
                    activeIcon: Icon(
                      Icons.ac_unit,
                      color: Colors.blue,
                    ),
                    title: Text("++")),
              ]),
          floatingActionButton:
              FloatingActionButton(onPressed: null, child: Text("Click")),
          body: _currentIdx == 0
              ? (RefreshIndicator(
                  // 一定要配合ListView
                  child: ListView(children: <Widget>[
                    Row(children: <Widget>[
                      ClipOval(
                          child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          "https://pic4.zhimg.com/v2-21574bc97e11efe8fd64eaa527d6b9b2_xs.jpg",
                          width: 100,
                          height: 100,
                        ),
                      )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Opacity(
                                opacity: 0.6,
                                child: Image.network(
                                  "https://pic4.zhimg.com/v2-21574bc97e11efe8fd64eaa527d6b9b2_xs.jpg",
                                  width: 100,
                                  height: 100,
                                ),
                              )))
                    ]),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.blue),
                      child: PhysicalModel(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                          clipBehavior: Clip.antiAlias,
                          child: PageView(children: <Widget>[
                            _item("Page1", Colors.deepOrange),
                            _item("Page2", Colors.deepPurple),
                            _item("Page3", Colors.blue),
                            _item("Page4", Colors.green),
                          ])),
                    ),
                    Column(children: <Widget>[
                      // 宽度盛满!
                      FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                              decoration: BoxDecoration(color: Colors.indigo),
                              child: Text("宽度撑满")))
                    ]),
                    Stack(children: <Widget>[
                      Image.network(
                        "https://pic4.zhimg.com/v2-21574bc97e11efe8fd64eaa527d6b9b2_xs.jpg",
                        width: 100,
                        height: 100,
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Image.network(
                          "https://pic4.zhimg.com/v2-21574bc97e11efe8fd64eaa527d6b9b2_xs.jpg",
                          width: 50,
                          height: 50,
                        ),
                      )
                    ]),
                    Wrap(
                        spacing: 8, // 水平
                        runSpacing: 6, // 垂直
                        children: <Widget>[
                          _chip("Flutter"),
                          _chip("Flutter"),
                          _chip("Flutter")
                        ])
                  ]),
                  onRefresh: _handleRefresh))
              : (Column(children: <Widget>[
                  Text("List"),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(color: Colors.yellow),
                          child: Text("拉伸填充")))
                ]))),
    );
  }

  Future<dynamic> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    return null;
  }

  Widget _item(String title, [Color color = Colors.deepOrange]) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title, style: TextStyle(fontSize: 22, color: Colors.white)),
    );
  }

  Widget _chip(String label) {
    return Chip(
        label: Text(label),
        avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child:
                Text(label.substring(0, 1), style: TextStyle(fontSize: 10))));
  }
}
