void main(List<String> arguments) {
  print(arguments);
  String aConstStr = "string!";
  int aConstNum = 333;
  dynamic aDynamicVar = "dynamic!";
  final String aFinalVar = "final!";
  const double aDoubleNum = 1.324;
  final bar = const []; // const 可省略
  print("who is $aConstStr");

  // double同理
  var getInt = int.parse("3434");
  print(getInt);
  //
  String getStr = aConstNum.toString();
  print(getStr);
  // ！
  String piAsString = 3.14159.toStringAsFixed(2);
  assert(piAsString == '3.14');
  print("${aConstStr.toUpperCase()}");
  bool aBoolean = true;
  // 使得数组无法被修改
  var lists = const [112121221, 2, 3, 4];
  print(lists[1]);
  var aMap = {"someKey": "someProp"};
  aMap['anotherKey'] = "anotherProp";
  print(aMap['someKey']);
  print(aMap['anotherKey']);
  int number = 42;
  printInteger(number);

  // function part!
  // bool boolFunc(int somNum) {
  //   return somNum > 1;
  // }
  // 仅一个表达式
  bool boolFunc(int somNum) => somNum > 1;

  print(boolFunc(0));

  // 这可不是解构
  void choose1(bool param1, {int param2 = 88888}) {
    print(param1);
    print(param2);
  }

  choose1(false);

  void choose2({bool param1 = false, int param2 = 78989}) {
    print(param1);
    print(param2);
  }

  // 不可带参数
  choose2();

  // 位置参数的例子
  String say(String from, String msg,
      [String device = "deeeevice", String mod]) {
    var result = '$from says $msg';
    if (device != null) {
      result = '$result with a $device';
    }
    return result;
  }

  print(say('Bob', 'Howdy'));
  print(say('Bob', 'Howdy', 'smoke signal'));
  // 区别应该是命名参数指定了就不能传了  但是位置参数还可以传

  // 将列表或map集合作为默认值
  // 咋同时使用两种？
  void doStuff(
      {List<int> list = const [1, 2, 3],
      Map<String, String> gifts = const {
        'first': 'paper',
        'second': 'cotton',
        'third': 'leather'
      }}) {
    print('list:  $list');
    print('gifts: $gifts');
  }

  doStuff();

  dynamic loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
  print(loudify('A'));
  // 匿名函数
  List<String> list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });
  // list.forEach(
  // (item) => print('${list.indexOf(item)}: $item'));

  // 闭包！熟悉的味道
  Function makeAdder(num addBy) {
    return (num i) => addBy + i;
  }

  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  print(add2(1));
  print(add4(11));

  // 运算符
  // as
  // var a = "s" as int;

  // is is!
  // if (emp is Person) {
  //   // Type check
  //   emp.firstName = 'Bob';
  // }
  // ？？
  var nullish = aBoolean ? "1" : "2";

  String playerName(String name) => name ?? 'Guest';

  // 级联
  Map<String, int> aMap1 = {"key": 1};
  aMap1
    ..["key2"] = 2
    ..["key3"] = 3;

  print(aMap1);

  // 流程控制
  var callbacks = [];
  for (var i = 0; i < 10; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());

  // for-in
  const List<int> collection = [1, 1, 2, 3];
  for (var x in collection) {
    print(x); // 打印值
  }

  // Dart支持空的case子句,支持fall-through的格式:
  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED': // Empty case falls through.
    case 'NOW_CLOSED':
      // 无论command是CLOSED还是NOW_CLOSED都执行
      // executeNowClosed();
      break;
  }
}

printInteger(int aNumber) {
  print('The number is $aNumber.');
}
