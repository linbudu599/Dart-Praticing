import 'package:flutter/material.dart';
import "./basic/stateless_group.dart";
import "./basic/sateful_group.dart";
import "layout/layout.dart";
import "./basic/plugin.dart";
import "./common/gesture.dart";
import "./common/launcher.dart";
import "./common/lifecycle.dart";
import "./common/app_lifecycle.dart";
import "app/camera.dart";
import "./router/route-param-receiver.dart";
import "./router/data-return-screen.dart";
import "./router/data-send-screen.dart";
import "network/network.dart";
import 'app/data-persistence.dart';
import "./components/Form.dart";
import "./components/Image.dart";
import "./navigator/navigation.dart";
import "app/shared_prefer.dart";
import "list/list.dart";
import "list/list_refresh.dart";
import "./components/Button.dart";
import "./container/container.dart";
import "./common/progressIndicator.dart";
import "./common/dialog.dart";
import "./event/event.dart";
import "./animation/animation.dart";

void main() {
  // runApp(StatelessWidgetGroup());
  runApp(DynamicTheme());
}

class DynamicTheme extends StatefulWidget {
  DynamicTheme({Key key}) : super(key: key);

  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness bright = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo11',
      theme: ThemeData(
        // fontFamily: "FiraCode",
        primarySwatch: Colors.blue,
        brightness: bright,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text("芜湖!")),
          body: SingleChildScrollView(child: RouterNavigator())),
      routes: <String, WidgetBuilder>{
        // "stateless": (BuildContext context) => StatelessGroup(),
        // "stateful": (BuildContext context) => StatefulGroup(),
        // "layout": (BuildContext context) => Layout(),
        // "gesture": (BuildContext context) => Gesture(),
        // "plugin": (BuildContext context) => ColorPlugin(),
        // "launcher": (BuildContext context) => URLLauncher(),
        // "lifecycle": (BuildContext context) => LifeCycle(),
        // "app_lifecycle": (BuildContext context) => AppLifecycle(),
        // "camera_app": (BuildContext context) => CameraApp(),
        // RouterParamReceiver.routeName: (BuildContext context) =>
        //     RouterParamReceiver(),
        // "data_return_screen": (BuildContext context) => ReturnDataHomeScreen(),
        // "data_send_screen": (BuildContext context) => DataSend2NewScreen(),
        // "network_demo": (BuildContext context) => NetworkDemo(),
        // "form": (BuildContext context) => CustomForm(),
        "image": (BuildContext context) => ImageDemo(),
        "top_navigation": (BuildContext context) => TopNavigationView(),
        "bot_navigation": (BuildContext context) => BotNavigationView(),
        "side_navigation": (BuildContext context) => SideNavigationView(),
        // "shared_prefs": (BuildContext context) => SharedPreferencesDemo(),
        // "list": (BuildContext context) => ListDemo(),
        // "refresh_list": (BuildContext context) => RefreshList(),
        "button_collection": (BuildContext context) => ButtonCollection(),
        "container": (BuildContext context) => ContainerCollection(),
        "progress": (BuildContext context) => ProgressIndicatorDemo(),
        "dialog": (BuildContext context) => DialogState(),
        "event": (BuildContext context) => EventDemo(),
        "animation": (BuildContext context) => AnimationDemo(),
      },
      onUnknownRoute: (RouteSettings settings) =>
          MaterialPageRoute(builder: (BuildContext context) => Text("")),
    );
  }
}

class RouterNavigator extends StatefulWidget {
  @override
  _RouterNavigatorState createState() => _RouterNavigatorState();
}

class _RouterNavigatorState extends State<RouterNavigator> {
  bool routeByName = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
        ),
        // 通过点击跳转或是导航
        // SwitchListTile(
        //     title: Text('${routeByName ? '' : '不'}通过路由名跳转'),
        //     value: routeByName,
        //     onChanged: (bool value) {
        //       setState(() {
        //         routeByName = value;
        //       });
        //     }),
        // _item("Less Widget", StatelessGroup(), "stateless"),
        // _item("Ful Widget", StatefulGroup(), "stateful"),
        // _item("Layout Widget", Layout(), "layout"),
        // _item("Gesture Widget", Gesture(), "gesture"),
        // _item("Plugin Widget", ColorPlugin(), "plugin"),
        // _item("Launcher Widget", URLLauncher(), "launcher"),
        // _item("LifeCycle Widget", LifeCycle(), "life cycle"),
        // _item("App LifeCycle Widget", AppLifecycle(), "app life cycle"),
        // _item("Camera App", CameraApp(), "czamera_app"),
        // _item(
        //     "Route Param Receiver",
        //     RouterParamReceiver(),
        //     RouterParamReceiver.routeName,
        //     ScreenArgs("SEND TITLE", "SEND MESSAGE")),
        // _item("Data Return To Home Screen", ReturnDataHomeScreen(),
        //     "data_return_screen"),
        // _item("Data Send To New Screen", DataSend2NewScreen(),
        //     "data_send_screen"),
        // _item("Network Demo", NetworkDemo(), "network_demo"),
        // _item("Form Demo", CustomForm(), "form"),
        // _item("Image Demo", ImageDemo(), "image"),
        // _item("Top Navigation Demo", TopNavigationView(), "top_navigation"),
        // _item("Bot Navigation Demo", BotNavigationView(), "bot_navigation"),
        // _item("Side Navigation Demo", SideNavigationView(), "side_navigation"),
        // _item("Shared_Pref Demo", SharedPreferencesDemo(), "shared_prefs"),
        // _item("List Demo", ListDemo(), "list"),
        // _item("Refresh List Demo", RefreshList(), "refresh_list"),
        // _item("Button Widget Collection", ButtonCollection(),
        //     "button_collection"),
        // _item("Container", ContainerCollection(), "container"),
        // _item("Progress", ProgressIndicatorDemo(), "progress"),
        // _item("Dialog", DialogState(), "dialog"),
        // _item("Event", EventDemo(), "event"),
        _item("Animation", AnimationDemo(), "animation")
      ]),
    );
  }

  _item(String title, Widget page, String route, [ScreenArgs args]) {
    return Container(
        child: RaisedButton(
            onPressed: () {
              if (routeByName) {
                Navigator.pushNamed(context, route, arguments: args);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => page,
                        settings: RouteSettings(arguments: args)));
              }
            },
            child: Text(title)));
  }
}
