# Stream

- 和 Node 中的流思路大致相同
- 使用 await for 或者 listen 来处理流
- Dart 中的流提供了错误处理方式
- 单个订阅与广播流（似乎不同于 node 中单向流与双工流）

```dart
import 'dart:async';

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}
```

接收错误：

当使用 await for 时接收到异常，会抛出这个异常

```dart
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (var value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw new Exception('Intentional exception');
    } else {
      yield i;
    }
  }
}

main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // -1
}
```

Stream 上存在许多有用的方法，如 lastWhere 返回流接收到的最后一个数据

单向订阅流：如读取文件或接收网络请求

只能被监听一次，后续的监听会错过初始事件，这就是无意义的了

广播流：如鼠标事件等，可以在任何时候开始监听，一个事件源可以被多个监听者订阅

底层方法 listen，stream 所有的方法都基于它

```dart
StreamSubscription<T> listen(void Function(T event) onData,
    {Function onError, void Function() onDone, bool cancelOnError});
```

这个方法用于开启一次监听，只有监听才能感知到事件

可以用来暂停、恢复、取消等
