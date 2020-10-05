import "package:flutter/material.dart";

class ScreenArgs {
  final String title;
  final String msg;

  ScreenArgs(this.title, this.msg);
}

class RouterParamReceiver extends StatefulWidget {
  RouterParamReceiver({Key key}) : super(key: key);

  static const String routeName = "/receiver";

  @override
  _RouterParamReceiverState createState() => _RouterParamReceiverState();
}

class _RouterParamReceiverState extends State<RouterParamReceiver> {
  @override
  Widget build(BuildContext context) {
    final ScreenArgs args =
        ModalRoute.of(context).settings.arguments ?? ScreenArgs("A", "B");
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title ?? "DEFAULT TITLE"),
      ),
      body: Center(
        child: Text(args.msg ?? "DEFAULT MESSAGE"),
      ),
    );
    ;
  }
}
