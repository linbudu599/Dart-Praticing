import "package:flutter/material.dart";

class StatefulGroup extends StatefulWidget {
  StatefulGroup({Key key}) : super(key: key);

  @override
  _StatefulGroupState createState() => _StatefulGroupState();
}

class _StatefulGroupState extends State<StatefulGroup> {
  int _currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StatefulWidget",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(title: Text("StatefulWidget")),
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
                    Text("Page1"),
                    Image.network(
                      "https://pic4.zhimg.com/v2-21574bc97e11efe8fd64eaa527d6b9b2_xs.jpg",
                      width: 100,
                      height: 100,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          hintText: "请输入",
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(color: Colors.blue),
                      child: PageView(children: <Widget>[
                        _item("Page1", Colors.deepOrange),
                        _item("Page2", Colors.deepPurple),
                        _item("Page3", Colors.blue),
                        _item("Page4", Colors.green),
                      ]),
                    )
                  ]),
                  onRefresh: _handleRefresh))
              : (Container(child: Text("Page2")))),
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
}
