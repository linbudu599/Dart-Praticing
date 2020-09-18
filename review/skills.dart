// 编程技巧
// 封装&继承&多态
// 功能模块封装 / 方法封装
// 一个方法中<100行
void main(List<String> args) {
  // 安全调用 ?. 可选链
  // ?? 空值合并
  // 简化判断
  List<dynamic> list = [];

  list.addAll([0, null, ""]);

  if ([0, null, ""].contains(list[0])) {}
}
