// 类型别名
// class SortedCollection {
//   Function compare;

//   SortedCollection(int f(Object a, Object b)) {
//     compare = f;
//   }
// }

// // Initial, broken implementation.
// int sort(Object a, Object b) => 0;

// void main() {
//   SortedCollection coll = SortedCollection(sort);

//   // All we know is that compare is a function,
//   // but what type of function?
//   assert(coll.compare is Function);
// }

typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

// Initial, broken implementation.
int sort(Object a, Object b) => 0;

void main() {
  SortedCollection coll = SortedCollection(sort);
  assert(coll.compare is Function);
  assert(coll.compare is Compare);
}

// 因为typedef仅仅是别名，所以它们提供了一种检查任何函数类型的方法。例如:

typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
