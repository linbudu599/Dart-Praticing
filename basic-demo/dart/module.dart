import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();

// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;

import 'package:greetings/hello.dart' deferred as hello;

Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}

// 异步支持
// Future->promise?
  Future<String> lookUpVersion() async => '1.0.0';

Future checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version

  // 注意:尽管异步函数可能执行耗时的操作，但它不会等待这些操作。
  // 相反，异步函数一直执行直到遇到第一个await表达式([查看详细信息])。然后它返回一个Futures的对象，只有在await表达式完成之后才恢复执行。

  // 也是用try catch

}