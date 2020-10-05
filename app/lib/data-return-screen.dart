import "package:flutter/material.dart";

class ReturnDataHomeScreen extends StatefulWidget {
  ReturnDataHomeScreen({Key key}) : super(key: key);

  @override
  _ReturnDataHomeScreenState createState() => _ReturnDataHomeScreenState();
}

class _ReturnDataHomeScreenState extends State<ReturnDataHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returning Data Demo'),
      ),
      // Create the SelectionButton widget in the next step.
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatefulWidget {
  SelectionButton({Key key}) : super(key: key);

  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  String selectText = "None Was Selected";

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(100)),
      RaisedButton(
          onPressed: () {
            _navigateToSelectPage(context);
          },
          child: Text("Get To Select Page")),
      Text(selectText, style: TextStyle(color: Colors.blueGrey, fontSize: 26))
    ]);
  }

  Future<void> _navigateToSelectPage(BuildContext context) async {
    final dynamic result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ReturnData2HomeScreen()));

    setState(() {
      selectText = result;
    });

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text("U Select $result!"),
      ));
  }
}

class ReturnData2HomeScreen extends StatefulWidget {
  ReturnData2HomeScreen({Key key}) : super(key: key);

  @override
  _ReturnData2HomeScreenState createState() => _ReturnData2HomeScreenState();
}

class _ReturnData2HomeScreenState extends State<ReturnData2HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pick!")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, "Opt1");
                    },
                    child: Text("Option11111"))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, "Opt2");
                    },
                    child: Text("Option22222")))
          ],
        )));
  }
}
