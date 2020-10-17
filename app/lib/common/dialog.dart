import 'package:flutter/material.dart';

// TODO: 最有效的方法: markNeedsBuild() 相当于直接修改状态更新底层

// 模仿Builder类 获取statefulWidget上下文 并 代理构建过程
class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}

class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}

class DialogState extends StatelessWidget {
  const DialogState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dialog"),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: <Widget>[DialogStateManage1()],
          ),
        )));
  }
}

class DialogStateManage1 extends StatefulWidget {
  DialogStateManage1({Key key}) : super(key: key);

  @override
  _DialogStateManageState createState() => _DialogStateManageState();
}

class _DialogStateManageState extends State<DialogStateManage1> {
  Future<bool> showDeleteConfirmDialog3() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  //  把复选框状态单独抽离出来 但这样需要每个带有状态的组件都抽离一次
                  // DialogCheckbox(
                  //   value: _withTree, //默认不选中
                  //   onChanged: (bool value) {
                  //     //更新选中状态
                  //     _withTree = !_withTree;
                  //   },
                  // ),
                  // 通过子组件通知父组件（StatefulWidget）重新build子组件本身来实现UI更新
                  StatefulBuilder(
                    builder: (context, _setState) {
                      return Checkbox(
                        value: _withTree, //默认不选中
                        onChanged: (bool value) {
                          //_setState方法实际就是该StatefulWidget的setState方法，
                          //调用后builder方法会重新被调用
                          _setState(() {
                            //更新选中状态
                            _withTree = !_withTree;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("状态管理对话框1"),
      onPressed: () async {
        //弹出删除确认对话框，等待用户确认
        bool deleteTree = await showDeleteConfirmDialog3();
        if (deleteTree == null) {
          print("取消删除");
        } else {
          print("同时删除子目录: $deleteTree");
        }
      },
    );
  }
}
