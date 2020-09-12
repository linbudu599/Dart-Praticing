void main() {
  // 类型编程关键字

  // as is is!

  List<int> int_list = [1, 2, 3];

  if (int_list is List) {
    // xxx
  }
  // as 就像类型断言

  // 空值合并
  dynamic a;

  // a为空时才会被赋值为变量值
  a ??= int_list;

  // 条件表达式
  // 三目运算符 与 真`空值合并

  // 级联运算后的代码执行返回值会被忽略
  // querySelector('#confirm') // 获取对象。
  // ..text = 'Confirm' // 调用成员变量。
  // ..classes.add('important')
  // ..onClick.listen((e) => window.alert('Confirmed!'));

  // 异常捕获
  // throw FormatException("Oops!");
  // throw "xxx"

  try {} on FormatException {} on Exception {} catch (e) {
    // 处理所有异常
    // 重新抛出
    // rethrow;
  } finally {
    // 最初必定执行
  }
}
