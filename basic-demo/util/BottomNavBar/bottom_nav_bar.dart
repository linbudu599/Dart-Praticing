import "package:flutter/material.dart";
import "./pages/email.dart";
import "./pages/home.dart";
import "./pages/phone.dart";
import "./pages/msg.dart";
import "./pages/pages.dart";

void main() => runApp(BottomNavBar());

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _navColor = Colors.blue;
  int _currentIdx = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list..add(Home())..add(Email())..add(Msg())..add(Phone())..add(Pages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _navColor),
            title: Text("Home", style: TextStyle(color: _navColor)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.email, color: _navColor),
              title: Text("Email", style: TextStyle(color: _navColor))),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone, color: _navColor),
              title: Text("Phone", style: TextStyle(color: _navColor))),
          BottomNavigationBarItem(
              icon: Icon(Icons.message, color: _navColor),
              title: Text("Message", style: TextStyle(color: _navColor))),
          BottomNavigationBarItem(
              icon: Icon(Icons.pages, color: _navColor),
              title: Text("Page", style: TextStyle(color: _navColor))),
        ],
        currentIndex: _currentIdx,
        onTap: (int index) {
          setState(() {
            _currentIdx = index;
          });
        },
      ),
    );
  }
}
