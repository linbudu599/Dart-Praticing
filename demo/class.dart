import 'dart:math';

class P {
  // 默认为null
  // num x;
  // num y;
  // num z = 0;
  num x, y;

  // 通过创建一个与类同名的函数来声明构造函数(另外，
  // 还可以像[命名构造函数]中描述的一样选择一个附加标识符)。构造函数最常见的应用形式是使用构造函数生成一个类的新实例：
  // 注意:只有在名称冲突时才使用它。否则，Dart的代码风格需要省略this
  // P(num x, {num y = 2}) {
  //   this.x = x;
  //   this.y = y;
  // }
  P(this.x, this.y);
  // 命名的构造函数
  P.origin() {
    x = 0;
    y = 0;
  }
}

class Point {
  num x, y;

  Point(this.x, this.y);

  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var p = P(1, 2);
  print(p.x);
  print(p.y);

  Point pp1 = Point(4, 77);
  Point pp2 = Point(54, 37);
  print(pp1.distanceTo(pp2));

  // 重写类的成员
  // class SmartTelevision extends Television {
  // @override
  // void turnOn() {...}
  // // ···
  // }

  // 枚举
  // enum Color  {"red", "green", "blue"};
  // assert(Color.red.index == 0);
  // assert(Color.green.index == 1);
  // assert(Color.blue.index == 2);
  // 要获取枚举中所有值的列表，请使用enum的values 常量。

  // List<Color> colors = Color.values;
  // assert(colors[2] == Color.blue);

  // 泛型
  // 这里的()因为是字面量语法
  var names = List<String>();
  names.addAll(['Seth', 'Kathy', 'Lars']);
  // names.add(42); // Error
  print(names);

  T first<T>(List<T> ts) {
    // Do some initial work or error checking, then...
    T tmp = ts[0];
    // Do some additional checking or processing...
    return tmp;
  }
}
