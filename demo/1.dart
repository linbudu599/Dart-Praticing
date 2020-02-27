// // 定义一个函数
// printInteger(int aNumber) {
//   print('The number is $aNumber.'); // Print to console.
// }

// // 程序执行入口
// main() {
//   var number = 42; // Declare and initialize a variable.
//   printInteger(number); // Call a function.
// }
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');

  const list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });
}
