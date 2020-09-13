// enum Color { red, green, blue }

// assert(Color.red.index == 0);

// print(Color.values);

// 泛型

abstract class Cache<T> {
  T getByKey(String key);

  void setByKey(String key, T value);
}

// 和ts的相对比较类似 在方法 函数上使用
T first<T>(List<T> list) {
  T tmp = list[0];
  return tmp;
}

void main(List<String> args) {}
