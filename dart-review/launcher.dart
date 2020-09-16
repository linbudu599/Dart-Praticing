import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";

class URLLauncher extends StatelessWidget {
  const URLLauncher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      RaisedButton(child: Text("打开浏览器"), onPressed: () => _launchURL()),
      RaisedButton(child: Text("打开地图"), onPressed: () => _openMap())
    ]));
  }

  Future<void> _launchURL() async {
    const String url = "https://linbudu.top";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  Future<void> _openMap() async {
    const String url = "geo:52.32,4.917";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw "Could not launch $url";
      const String IOSUrl = "https://maps.apple.com/?ll=52.32,4.917";
      if (await canLaunch(IOSUrl)) {
        await launch(IOSUrl);
      } else {
        throw "Could not launch $IOSUrl";
      }
    }
  }
}
