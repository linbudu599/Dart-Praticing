# Flutter 测试

## 单元测试

- 添加`test`依赖到 dev_deps 并引入
- 测试文件应该以`_test`结尾（会作为测试用例判别的依据）

```dart
class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}
```

```dart
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';

void main() {
  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}

```

> test 相当于 jest 中的 it，是一个单独的测试用例
>
> group 相当于 jest 中的 test，收集一组用例

### 模拟依赖、服务等

- 基于 Mockito 进行 mock

```dart
class Post {
  dynamic data;
  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// 需要在每个测试文件中新建
// 集成Client类来将MockClient代替HttpClient
// 并且可以在每次测试中返回不同结果
class MockClient extends Mock implements http.Client {}

// 对于请求类型的模拟 通常需要模拟成功和失败情况

main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();
    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      // 模拟成功
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      expect(await fetchPost(client), isA<Post>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
        // 模拟失败
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}
```

### Mockito API 收录

WIP

## 组件测试

test 包提供的组件测试能力：

- WidgetTester 类似 Enzyme 的 shallow/mount，提供可供交互的测试环境，基于 testWidgets()创建，替代掉单元测试中的 test
- Finder 类似于 Enzyme 的 find 在测试环境中寻找特定控件
- Matcher 确认 Finder 是否匹配到了控件

```dart
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // 构建渲染待测试控件
		await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

> 使用 pump 创建后，后续面对如 statefulWidget 这一类控件的测试，需要再调用其他方法重新构建测试控件，如括定时（测试动画）等

感觉上 Matcher 就像 Jest 内置的匹配检验，如 toBeLess、toEuqal 这样，但 flutter 这里并没有也并不需要这么多

### 常用 Finder、Matcher

```dart
testWidgets('finds a Text widget', (WidgetTester tester) async {

  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));
	// 查找内部是H的文字控件
  expect(find.text('H'), findsOneWidget);
});

// 基于Key查找（列表场景）
testWidgets('finds a widget using a Key', (WidgetTester tester) async {
  final testKey = Key('K');

  await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

  expect(find.byKey(testKey), findsOneWidget);
});

// 查找特定控件实例
testWidgets('finds a specific instance', (WidgetTester tester) async {
  final childWidget = Padding(padding: EdgeInsets.zero);

  await tester.pumpWidget(Container(child: childWidget));

  // 确保某个控件被渲染
  expect(find.byWidget(childWidget), findsOneWidget);
});

```

### 用户行为

WidgetTester 内置 enterText() tap() drag() 方法

```dart
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


void main() {
  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    await tester.pumpWidget(TodoList());
    await tester.enterText(find.byType(TextField), 'hi');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('hi'), findsOneWidget);
    // 牛皮
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    // build并确保界面上动效等都已执行完毕
    await tester.pumpAndSettle();
    expect(find.text('hi'), findsNothing);
  });
}
```

## 集成测试

- 整体功能
- 性能测试

**暂时跳过**

[完整 Demo](https://codelabs.developers.google.com/codelabs/flutter-app-testing/#3)
