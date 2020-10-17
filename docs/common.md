# 通用

## 下拉刷新

## 上拉加载更多

## 唤起本地相机功能

## 手势检测

## 拖拽

## keep-alive

## 搜索栏

## 夜间模式

```dart
                RaisedButton(
                  child: Text(
                    "toggle to ${bright == Brightness.light ? 'night' : 'day'} mode",
                    style: TextStyle(fontFamily: "FiraCode"),
                  ),
                  onPressed: () {
                    setState(() {
                      bright = bright == Brightness.light
                          ? Brightness.dark
                          : Brightness.light;
                    });
                  }),
```

## 对话框

AlertDialog: "确定要删除...吗?"的场景, 使用`Navigator.of(context).pop(result)`返回. 

showDialog(): 用于弹出对话框并获取对话框的返回值(通过点击遮罩关闭,则值为null), 不一定要返回Dialog类

```dart
// return Dialog(child: child) 
return UnconstrainedBox(
  constrainedAxis: Axis.vertical,
  child: ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 280),
    child: Material(
      child: child,
      type: MaterialType.card,
    ),
  ),
);
```

SimpleDialog: 无操作项, 用于切换语言配置等(展示一个列表)

Dialog: 基类

showGeneralDialog(): 打开一个非MD风格的 对话框(showDialog的基类) 自定义遮罩颜色 切换时长等, 原理:

```dart
Future<T> showGeneralDialog<T>({
  @required BuildContext context,
  @required RoutePageBuilder pageBuilder,
  bool barrierDismissible,
  String barrierLabel,
  Color barrierColor,
  Duration transitionDuration,
  RouteTransitionsBuilder transitionBuilder,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(_DialogRoute<T>(
    pageBuilder: pageBuilder,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder,
  ));
}
```

通过路由的方式来实现

- showModalBottomSheet: 底部菜单列表
- showBottomSheet 底部全屏菜单
- LoadingDialog: 需要使用showDialog + AlertDialog 自定义
  > 在这种情况下想要设置尺寸需要先移除掉源码集成的限制

  ```dart
  UnconstrainedBox(
    constrainedAxis: Axis.vertical,
    child: SizedBox(
      width: 280,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(value: .8,),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: Text("正在加载，请稍后..."),
            )
          ],
        ),
      ),
    ),
  );
  ```

## 日历

```dart
// 安卓
Future<DateTime> _showDatePicker1() {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: date,
    lastDate: date.add( //未来30天可选
      Duration(days: 30),
    ),
  );
}
// IOS
Future<DateTime> _showDatePicker2() {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(
            Duration(days: 30),
          ),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            print(value);
          },
        ),
      );
    },
  );
}
```