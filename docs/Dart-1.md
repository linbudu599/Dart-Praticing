# Dart-1 初体验

写个锤子文档读后感  直接上手敲代码吧

第一个示例程序

main 入口函数

int 

print()

$variableName / ${expression}

var 声明变量而不指定类型

- 在变量中可以放置的所有东西都是*对象*，而每个对象都是*类*的实例。无论数字、函数和null都是对象。所有对象都继承自[Object]类。

怪不得会显示abstract class int extends num

- 如果要明确说明不需要任何类型，请使用[特殊类型dynamic]。
- 泛型？List<int>(整数列表)或List<dynamic>(任何类型的对象列表)

- dynamic->any？
- 顶级函数(如main())，以及绑定到类或对象(分别是静态方法（static）和实例（instance）方法)的函数
- Dart支持顶级变量，以及绑定到类或对象(静态和实例变量)的变量。实例变量有时被称为字段或属性。
- 如果标识符以下划线(_)开头，则该标识符对其库是私有的



关键字，还不少哈



字符串也是对象！变量包含的是对字符串对象引用！

```dart
var name = 'Bob';
dynamic name = 'Bob';
String name = 'Bob';
// 对本地变量使用var而不是类型注解的风格指南建议
```



未初始化就为null！不管啥类型

 

> 最终变量只能设置一次;const变量是一个编译时常数。(Const变量是隐式最终变量。)最终的顶级或类变量在第一次使用时被初始化。

喵喵喵？

```
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
```

无法更改

对于想要在编译时确定并且不再变的变量，使用const。如果const变量位于类级别，则将其标记为静态const。在声明该变量时，将该值设置为编译时常量，例如数字或字符串字面量、const变量或常量数字算术运算的结果:

```
const bar = 1000000; // Unit of pressure (dynes/cm2)
const double atm = 1.01325 * bar; // Standard atmosphere
```

const关键字不只是声明常量变量。您还可以使用它来创建常量值，以及声明创建常量值的构造函数。任何变量都可以赋一个常量值。

```
var foo = const [];
final bar = const [];
const baz = []; // Equivalent to `const []`
```

```
foo = [1, 2, 3]; // Was const []
```

你不能改变const变量的值:

```
baz = [42]; // Error: Constant variables can't be assigned a value.
```



有点懵 我理理：

var foo = const []，被var修饰的foo可以被修改，

bar baz 的值被const修饰所以不能改？天了噜



## 内置类型

- [Numbers](https://www.kancloud.cn/marswill/dark2_document/709091#Numbers_17)

- - [int](https://www.kancloud.cn/marswill/dark2_document/709091#int_19)
  - [double](https://www.kancloud.cn/marswill/dark2_document/709091#double_21)

- [字符串](https://www.kancloud.cn/marswill/dark2_document/709091#_71)

- [Booleans](https://www.kancloud.cn/marswill/dark2_document/709091#Booleans_148)

- [Lists](https://www.kancloud.cn/marswill/dark2_document/709091#Lists_171)

- [Maps](https://www.kancloud.cn/marswill/dark2_document/709091#Maps_202)

- [Runes（字符）](https://www.kancloud.cn/marswill/dark2_document/709091#Runes_277)

- [Symbols（符号）](https://www.kancloud.cn/marswill/dark2_document/709091#Symbols_311)

指向一个对象——类的实例——你通常可以使用构造函数来初始化变量。有些内置类型有自己的构造函数。例如，可以使用Map()构造函数创建映射。

String() Number()？



数字：int double

类型互转

```
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```

字符串转数字：.parse(str)



'$var' 直接就行  如果是表达式要加{}

== 检验两个对象是否相等，有===吗？



你可以用r前缀创建一个“原始”字符串:

```
var s = r'In a raw string, not even \n gets special treatment.';
```

啥？



```
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
```



意思是非常量声明的值不能当成模板字符串？

Dart的类型安全性意味着您不能使用if(非booleanvalue)或assert(非booleanvalue)之类的代码



if(!!var)再见了，等我用js我会继续想起你的



数组->列表对象

```
var list = [1, 2, 3];
```

> 注意:分析器推断该列表具有List<int>类型。如果试图向此列表添加非整型对象，则分析器或运行时将引发错误。有关更多信息，请阅读[有关类型推断的文章]。

```
var constantList = const [1, 2, 3];
// constantList[1] = 1; // Uncommenting this causes an error.
```



嚯，🐂



map

```
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
```

注意：解析器推断gifts的类型为Map<String, String>，nobleGases的类型为Map<int, String>。如果您试图向map添加错误类型的值，则分析器或运行时将引发错误。更多内容参见[类型推断]



好的好的，有点像es6的map，不知道能不能用对象当键名

您同样可以使用Map构造函数创建对象:

```
var gifts = Map();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

> 注意:你可能觉得我们应该使用new Map()而不是使用Map()来创建一个对象。但是，在Dart2中new关键字是可选的。有关详细信息参见[使用构造函数]

如果你要获取的键不再map中，将会返回一个null：

使用.length获取map中元素的个数:

要创建一个编译时常量的map需要在map的字面量前加const关键字：

```
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
```



函数！

也是一等公民，函数分配给变量或作为参数~

```
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
// 箭头函数！！
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

不能是语句，只能有一个表达式

打扰了



可选的命名参数

```
enableFlags(bold: true, hidden: false);
```

```
void enableFlags({bool bold, bool hidden}) {...}
```

您可以在任何Dart代码(不仅仅是Flutter)中注释一个已命名的参数，并使用@required说明它是一个必传的参数。例如:

```
const Scrollbar({Key key, @required Widget child})
```



可选的位置参数

在[]中包装一组函数参数，标记为可选的位置参数:

```
在[]中包装一组函数参数，标记为可选的位置参数:

String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
这里有一个调用这个函数的例子，没有可选参数:

assert(say('Bob', 'Howdy') == 'Bob says Howdy'); 

这里有一个用第三个参数调用这个函数的例子:

assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
```



您的函数可以使用 = 来定义命名和位置参数的默认值。默认值必须是编译时常量。如果没有提供默认值，则默认值为null。

下面是为命名参数设置默认值的示例:

```
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold will be true; hidden will be false.
enableFlags(bold: true);
```



怎么感觉有点不对劲



位置参数的默认值

```
String say(String from, String msg,
    [String device = 'carrier pigeon', String mood]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}

assert(say('Bob', 'Howdy') ==
    'Bob says Howdy with a carrier pigeon');
```

您还可以将列表或map集合作为默认值。下面的示例定义一个函数doStuff()，该函数指定列表参数的默认列表和礼品参数的默认map集合。

```
void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}
```



main函数有一个可选的列表参数

```
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```



可以将函数作为参数传递给另一个函数。例如:

```
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// Pass printElement as a parameter.
list.forEach(printElement);
```

你也可以为变量分配一个函数，例如:

```
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```



匿名函数

```
void main() {
  var list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });
}
// 使用 af
list.forEach(
    (item) => print('${list.indexOf(item)}: $item'));
```



词法作用域

老朋友了  也是作用域层层嵌套

```
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```

还有闭包！

```
/// Returns a function that adds [addBy] to the
/// function's argument.
Function makeAdder(num addBy) {
  return (num i) => addBy + i;
}

void main() {
  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```

哦哦哦原来全局不是只能有一个main函数吗

那别的东西也可以放外面了





操作符

| 操作符 | 说明                              |
| :----- | :-------------------------------- |
| as     | 形态转换                          |
| is     | 如果对象具有指定的类型，则为True  |
| is!    | 如果对象具有指定的类型，则为False |

类型断言和类型守卫？

使用as操作符将对象转换为特定类型。一般来说，您应该将其作为 is 测试的简写形式，以使用该对象的表达式对对象进行测试。

```
if (emp is Person) {
  // Type check
  emp.firstName = 'Bob';
}
```

使用as操作符可以使代码更简短:

```
(emp as Person).firstName = 'Bob';
```



```
///仅仅在b为空的情况下b被赋值value否则b的值不变
b ??= value;
```



级联！之前没见过

级联(..)允许您在同一个对象上创建一个操作序列。除了函数调用之外，您还可以访问同一对象上的字段。这通常可以省去创建临时变量的步骤，能使你更为流畅的写代码。

请看下边的代码：

```
querySelector('#confirm') // Get an object.
  ..text = 'Confirm' // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
```

首先调用querySelector()方法返回一个selector对象。跟随级联表示法的代码对这个选择器对象进行操作，忽略可能返回的任何后续值。

前面的例子等价于:

```
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
```

你也可以嵌套级联操作。例如：

```
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
```

在返回实际对象的函数上构造级联要小心。例如，以下代码会出错:

```
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
```

上例中sb.write()返回结果为void，所以你不能再一个void结果上继续构建级联操作。

> 注意:严格地说，级联的“..”表示法不是运算符。这只是Dart语法的一部分。



哦吼，好东西啊不用tmp了



也支持 ?. 



流程控制语句

if else有个区别就是不能用0 负数表示false



### For循环

你可以使用标准for循环进行迭代操作(处理重复的操作)，例如：

```
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}
```

Dart for循环内部的闭包捕获了索引的值，避免了JavaScript中常见的陷阱。例如:

```
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}
callbacks.forEach((c) => c());
```

哈哈哈哈哈哈啊哈哈怎么感觉被嘲讽了

是因为它的var并不是全局作用域吗，也不会被挂载到window上？



如果要迭代的对象是可迭代的，那么可以使用forEach()方法。使用forEach()本身是没有迭代计数器的，也就是for循环本身有i值在forEach()本身是没有的。

```
candidates.forEach((candidate) => candidate.interview());
```

可迭代类如List和Set也支持for-in形式的迭代:

```
var collection = [0, 1, 2];
for (var x in collection) {
  print(x); // 0 1 2
}
```

### While 和 do-while 循环

while循环在循环之前先检验条件是否为真，例如：

```
while (!isDone()) {
  doSomething();
}
```

do-while循环在一次循环结束之后检查条件是否为真，例如：

```
do {
  printLine();
} while (!atEndOfPage());
```

复制

> 译者注：所以使用while和do-while要非常小心，因为使用do-while如果条件为假也会至少执行一次循环体中的语句。



switch case

Dart支持空的case子句,支持fall-through的格式:

```
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // Empty case falls through.
  case 'NOW_CLOSED':
    // 无论command是CLOSED还是NOW_CLOSED都执行
    executeNowClosed();
    break;
}
```

如果你真的需要使用fall-through格式，你可以使用continue语句和一个标签，例如：

```
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  // Continues executing at the nowClosed label.

  nowClosed:
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
```



捕获异常将阻止异常传播(除非重新抛出异常)。捕获异常后我们可以去判断并处理相应的异常。

```
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```

要处理可以抛出多种异常类型的代码，可以指定多个catch子句。与抛出对象的类型匹配的第一个catch子句处理异常。如果catch子句没有指定类型，则该子句可以处理任何类型的抛出对象:

```
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
```

更细了  注意有三种情况



当您的异常处理程序需要异常对象时，请使用catch。

可以指定catch()的一个或两个参数。第一个是抛出的异常，第二个是堆栈跟踪(StackTrace对象)。

```
try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```

要在捕获中处理异常，同时允许其继续传播，请使用rethrow关键字。

```dart
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // Allow callers to see the exception.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```



要确保在抛出异常时运行某些业务代码，请使用finally子句。如果没有catch子句匹配异常，则在finally子句运行后传播异常:

```
try {
  breedMoreLlamas();
} finally {
  // Always clean up, even if an exception is thrown.
  cleanLlamaStalls();
}
```

finally子句在所有匹配到的catch子句之后运行:

```
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // Handle the exception first.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
```