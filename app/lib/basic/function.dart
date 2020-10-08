import 'package:flutter/material.dart';
import "basic.dart";

void main() {
// 返回值类型前置式定义
  bool isFool(int id) {
    return id % 2 == 0;
  }

// 箭头函数yes

// 命名/位置 可选参数

  void funcWithOptionalNameArgs(bool flag, @required int id) {}

  void funcWithOptionalPlaceArgs(bool flag, [int id = 1]) {
    print("芜湖!");
  }

  // 默认参数值
  void funcWithDefaultArgs({bool flag = false, String msg}) {}

  funcWithDefaultArgs(flag: true);

  // List Map 也可作为默认值

  // 将函数作为参数
  List<String> str_list = ['1', '2'];
  void printElement(String element) {
    print(element);
  }

  str_list.forEach(printElement);

  // 匿名函数
  str_list.forEach((item) {});

  // 闭包
  Function makeAdder(num addBy) => (num i) => addBy + i;

  final Function adder2 = makeAdder(2);
  final Function adder4 = makeAdder(4);

  assert(adder2(3) == 5);
  assert(adder4(3) == 7);
}
