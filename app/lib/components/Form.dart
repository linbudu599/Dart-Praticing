import "package:flutter/material.dart";

class CustomForm extends StatefulWidget {
  CustomForm({Key key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

// 保存表单相关数据类
class _CustomFormState extends State<CustomForm> {
  // 表单的唯一标识符  同时在校验时使用(获取到表单)
  // 在复杂的场景下 建议使用Form.of()
  final _formKey = GlobalKey<FormState>();

  String currentVal;

  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Text Field Controller: ${textFieldController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form Demo",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Form Demo"),
          ),
          // FIXME: Scaffold.of() called with a context that does not contain a Scaffold.
          // 发生在直接使用了实例化Scaffold的控件所处的上下文 正确应该是使用Scaffold的子元素的上下文
          body: Builder(
              builder: (context) => Column(
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Enter your username'),
                                  validator: (String val) {
                                    return val.isEmpty
                                        ? "SHOULD NOT BE EMPTY"
                                        : null;
                                  },
                                ),
                                TextField(
                                  controller: textFieldController,
                                  onChanged: (String text) {
                                    setState(() {
                                      print("Current Val: $text");
                                      currentVal = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter a search term'),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: RaisedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Well Done!"),
                                            ));
                                          }
                                        }))
                              ])),
                      FloatingActionButton(
                          onPressed: () {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(textFieldController.text),
                                );
                              },
                            );
                          },
                          tooltip: "Show Value",
                          child: Icon(Icons.text_fields))
                    ],
                  ))),
    );
  }
}
