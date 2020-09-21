import 'package:flutter/material.dart';

final List<String> CITY_LIST = const [
  '北京',
  '上海',
  '广州',
  '深圳',
  '杭州',
  '苏州',
  '成都',
  '武汉',
  '郑州',
  '洛阳',
  '厦门',
  '青岛',
  '拉萨'
];

final Map<String, List<String>> CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class ListDemo extends StatelessWidget {
  const ListDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("列表")),
        body: Container(
            // height: 1000,
            child: ListView(
                // scrollDirection: Axis.horizontal,
                // children: _horizonItemBuilder()
                // children: _expansionItemBuilder()
                children: _verticalItemBuilder())

            // child:
            //     GridView.count(crossAxisCount: 2, children: _gridItemBuilder()),
            ));
  }

  List<Widget> _verticalItemBuilder() {
    return CITY_LIST.map((city) => _verticalItem(city)).toList();
  }

  List<Widget> _horizonItemBuilder() {
    return CITY_LIST.map((city) => _horizonItem(city)).toList();
  }

  List<Widget> _gridItemBuilder() {
    return CITY_LIST.map((city) => _gridItem(city)).toList();
  }

  List<Widget> _expansionItemBuilder() {
    List<Widget> widgets = [];
    CITY_NAMES.forEach((key, value) {
      widgets.add(_expansionItem(key, CITY_NAMES[key]));
    });
    return widgets;
  }

  Widget _gridItem(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _expansionItem(String city, List<String> subCities) {
    return ExpansionTile(
        title: Text(
          city,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
        children: subCities.map((subCity) => _buildSub(subCity)).toList());
  }

  Widget _buildSub(String subCity) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Text(subCity),
        ));
  }

  Widget _verticalItem(String city) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget _horizonItem(String city) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
