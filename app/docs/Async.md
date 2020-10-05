# 异步相关

- Future函数可以直接在initState里调用
- 不是的!!! 是因为FutureBuilder
- 也可以 aFutureFunc().then(()=>{})
- 实现一个工厂函数来帮助转换http.response到Dart Object
- Future用法
  - then
  - async await
  - whenComplete
  - timeout

  ```dart
    main() {
        testFuture().then((s) {
            print(s);
        }, onError: (e) {
            print('onError:');
            print(e);
        }).catchError((e) {
            print('catchError:');
            print(e);
        });
        }

    // whenCompleted 就像 finally
    void main() {
        var random = Random();
        Future.delayed(Duration(seconds: 3), () {
            if (random.nextBool()) {
            return 100;
            } else {
            throw 'boom!';
            }
        }).then(print).catchError(print).whenComplete(() {
            print('done!');
        });
        }
    // 设置超时时间
    void main() {
        new Future.delayed(new Duration(seconds: 3), () {
            return 1;
        }).timeout(new Duration(seconds: 2)).then(print).catchError(print);
        }
  ```

- JSON解析 比如Map中存放字段
  ```dart
    
CommonModel model = CommonModel.fromJson(map);
print('icon： ${model.icon}');
print('title：${model.title}');


class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
  ```

- 复杂JSON解析

```json
{
  "url": "xxx",
  "tabs": [
    {
      "labelName": "推荐",
      "groupChannelCode": "tourphoto_global1"
    },
    {
      "labelName": "拍照技巧",
      "groupChannelCode": "tab-photo"
    }
  ]
}
```

```dart
class TravelTabModel {
  final String url;
  final List<TravelTab> tabs;

  TravelTabModel({this.url, this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    String url = json['url'];
    List<TravelTab> tabs =
        (json['tabs'] as List).map((i) => TravelTab.fromJson(i)).toList();
    return TravelTabModel(url: url, tabs: tabs);
  }
}

class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }
}
```