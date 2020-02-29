# Dart-2

类

- 基于 mixin 的继承
- 每个对象都是一个类的实例

构造两个相同的编译时常量会生成一个单一的、规范的实例:

```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!
在常量上下文中，可以在构造函数或文字之前省略 const。例如，看看这个代码，它创建了一个 const 的 map 集合:

// Lots of const keywords here.
const pointAndLine = const {
'point': const [const ImmutablePoint(0, 0)],
'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

（类的部分先不做深入，毕竟我TS的类都还写的不溜呢...）