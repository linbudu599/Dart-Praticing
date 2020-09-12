import "dart:math";

void main(List<String> args) {
  // 指定类型(可自动推导) 与 声名类型可变
  String str = "string";
  String tpl_str = '${str}_tpl';
  String long_str = '''
    Wu Hu!
  ''';
  int num_int = 1;
  double num_double = 1.0;
  bool bool_var = false;
  // 理解为Array
  List<String> str_list = ['1', '2'];

  // 未初始化的变量 即使是数字类型 默认值也为null

  // final 与 const
  // final 类似于 ES6的const
  // 而const理解为编译时就固定 static const
  // 可理解为 UNCHANGABLE_VAR blabla这种固定常量
  // final const是可以同时使用的
  const List<int> unchangeable_arr = [];
  unchangeable_arr.add(1); // ok
  // unchangeable_arr = [1]; // 8行

  // Set 就像ES6 的Set 是元素唯一的集合
  final Set<String> set_var = const {"2", "1"};
  // {} 默认是Map<dynamic, dynamic> 类型

  // 也可以Map() 但不需要带上new
  final Map<String, String> map_var = const {"a": "a"};
}
