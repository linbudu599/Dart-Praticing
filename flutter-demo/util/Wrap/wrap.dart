import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  List<Widget> list;

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
    return GestureDetector(
      onTap: () {
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
