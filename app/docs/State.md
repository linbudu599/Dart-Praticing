# State Management

- 声明式编程 UI = f(Code)
- 短时状态 Ephermeral State, 只需要用stateful widget自己进行管理(setState)即可 不会进行共享
- 应用状态 App State, 需要在多个widget间进行共享, 不应该再在widget间进行传递来去. 应当使用全局状态管理(Redux + React-Redux这种).
  - 个性化选项
  - 购物车
  - 登陆状态信息


## provider

- ChangeNotifier 数据存放处
- ChangeNotifierProvider 提供数据的地方 会在其中创建对应的ChangeNotifier
- Cousumer 需要使用数据的widget


## DRAFT

比如我们在应用的根widget中通过InheriteWidget共享了一个数据，那么我们便可以在任意子widget中来获取该共享的数据。
这个特性在一些需要在widget树中共享数据的场景中非常方便，比如Flutter SDK中正是通过InheritedWidget来共享应用主题(Theme)和Locale（当前语言环境）信息的。

Tips: InheritedWidget和React中的context功能类似，和逐级传递数据相比，它们能实现组件跨级传递数据。InheritedWidget的在widget树中数据传递方向是从上到下的，这和通知Notification的传递方向正好相反。

didChangeDependencies
我们知道StatefulWidget的State对象有一个didChangeDependencies回调，它会在“依赖”发生变化时被Flutter Framework调用。而这个“依赖”指的就是子Widget是否使用了父Widget中InheritedWidget的数据。

如果使用了，则代表子widget依赖有依赖InheritedWidget
如果没有使用则代表没有依赖
这种机制可以使子组件在所依赖的InheritedWidget变化时来更新自身。比如当主题、locale（语言）等发生变化时，依赖其的子Widget的didChangeDependencies方法将会被调用。
