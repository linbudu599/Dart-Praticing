class Point {
  num x;
  num y;
  num z = 0;

  // 内置单例模式?
  // static final Point
  Point(this.x, this.y);
  // 默认构造函数没有参数并调用父类的无参构造函数
  // 构造函数不会被继承!
  // 注意执行顺序: 初始化参数列表 - 父类无名构造函数 - 子类无名构造函数

  // 命名构造函数
  // 作用呢?
  Point.origin() {
    x = 0;
    y = 0;
  }

  Point.other(Map data) {
    print('in Person');
  }

  // 重定向构造函数
  Point.redirect(num x) : this(x, 0);

  // 初始化实例变量 初始列表
  // 会在构造函数体执行前初始化
  Point.fromJSON(Map<String, num> data)
      : x = data['x'],
        y = data['y'] {
    print('In Point.fromJSON(): ($x, $y)');
  }
}

// 常量构造函数 单例!
class ImmutablePoint {
  static final ImmutablePoint origin = const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}

// getter 与 setter
class Rectangle {
  num l, t, w, h;
  Rectangle(this.l, this.t, this.w, this.h);

  num get r => l + w;
  set r(num v) => l = v - w;

  num get b => t + h;
  set b(num v) => t = v - h;
}

class Extender extends Point {
  // 父类构造函数会先执行 因此参数可以是表达式/方法
  Extender.other(Map data) : super.other(data) {
    print('in Employee');
  }
}

// 抽象类
abstract class Doer {
  num x, y;
  String name = "不渡";
  Map<String, num> map = {"id": 1};

  void doSth();
}

class TruthDoer extends Doer {
  void doSth() {}
}

void main() {
  Point p = Point(1, 2);
  // 防止为null
  p?.x;
  print(p.x);

  var emp = new Extender.other({});

  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.l == 3);
  rect.r = 12;
  assert(rect.l == -8);
}
