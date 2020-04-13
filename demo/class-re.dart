class P {
  num x, y;

  P(this.x, this.y);

  P.namedCons(num x, num y) {
    this.x = x + 11;
    this.y = y + 22;
  }
}

class E extends P {
  E.namedCons(num x, num y) : super.namedCons(x, y) {
    this.x = x + 111;
    this.y = y + 222;
  }
}

// 构造函数不会从父类继承, 包括命名构造函数
// 如果想要在子类中使用定义在超类中的命名构造函数, 就必须在子类中实现
void main() {
  // final p = new P(1, 2);
  final P p = new P.namedCons(1, 2);
  print(p.x);

  final E e = new E.namedCons(11, 22);
  print(e.x);
}
