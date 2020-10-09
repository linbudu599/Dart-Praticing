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