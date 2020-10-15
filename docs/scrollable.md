# 可滚动组件

在组件内容尺寸超出当前视口时，Flutter 会报出 overflow 错误，需要使用可滚动组件进行包裹。

ListView 与 GridView 都是可滚动组件，内部都直接或间接包含一个 Scrollable 组件如 SingleChildScrollView

- axiosDirection

- controller

  是

- physics 决定可滚动组件如何响应用户的滑动操作，如抬起手指后继续执行动画以及滑动到边界等

  以滑动到边界为例，默认下 Flutter 会在 IOS 上出现弹性效果，在安卓上微光效果。可以通过显式指定来在不同平台下使用同种效果

  - ClampingSP 安卓下微光效果
  - BouncingSP IOS 下弹性效果

- controller 控制滚动位置、监听滚动事件

  默认下 Widget 树中的 PrimarySC 会被使用（子组件的可滚动组件没有指定 controller，且 primary 属性为 true）。如此一来，父组件就可以使用这种机制控制子组件中可滚动组件的滚动行为。

- Scrollbar 控件，用于为可滚动组件添加滚动条（child 需要是可滚动组件），在 IOS 自动切换为 CupertinoScrollbar

- Sliver，懒加载当前不在视口范围内的“薄片”，ListView 支持，SingleChildScrollView 不支持

## SingleChildScrollView

- reverse 按照阅读方向相反的方向进行滑动 实际上决定了开始可滚动的位置
- primary 上文提到，在没有指定 controller 时默认为 true

通常在不超出视口范围太多时使用，毕竟不支持 Sliver，性能开销大

## ListView

> 可滚动组件通过一个 List 来作为其 children 属性时，只适用于子组件较少的情况，这是一个通用规律，并非`ListView`自己的特性，像`GridView`也是如此，而可滚动组件的构造函数如果需要一个 itemBuilder，则通常是支持基于 Sliver 的懒加载模型的

- ListView 会一次性创建好所有列表项，就像 SCSV+Column 布局

- ListView.builder 适合列表项较多 会在进入视口才调用构建器创建
  - itemBuilder
  - itemCount
- ListView.separated 提供分割控件构建器

各构造函数公共参数

- itemExtent 组件的占据大小（根据滚动方向来判断是高度还是宽度），有助于优化子组件构建性能
- shrinkWrap 是否根据子组件总长度设置 ListView 长度，默认为 false。默认下 LV 会尽可能在滚动方向多占用空间，当 LV 在一个滚动方向上无边界的容器内部时，该属性必须为 true
- addAutomaticKeepAlives 在列表滑出视口后是否保活，对于自己维护 keepalive 状态的列表项，该属性必须为 false
- addRepaintBoundary 包裹以避免列表项重绘，当列表项重绘开销小时可能起到反作用。同样在自己维护 keepalive 时必须为 false

固定表头

不能直接 ListTile 后面跟着 ListView 这样 LV 高度边界无法确定，需要包裹在一个 SizedBox 内，其高度为高度-状态栏（24）-导航栏（56）-ListTile 表头（56）（为了使剩下的列表项均匀分配）

也可使用 Flex（Expanded）来自动拉伸组件

## GridView

二维网格列表构建，需要关注子组件的排列方式

SliverGridDelegate gridDelegate

预先实现的布局算法

- SliverGridDelegateWithFixedCrossAxisCount 横轴固定数量

  - mainAxisSpacing 主轴方向间距
  - crossAS 横轴子元素数量 该属性会子元素在横轴长度
  - childAspectRatio 子元素在横轴与主轴长度比例 在上一属性确定后，通过此属性进一步确定子元素在主轴长度

- SliverGridDelegateWithMaxCrossAxisExtent 横轴子元素为固定的最大长度

  ```dart
  SliverGridDelegateWithMaxCrossAxisExtent({
    // 子元素最大长度 但注意仍会等分
    double maxCrossAxisExtent,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  })
  ```

GridView.count 快速创建横轴子元素数量固定的子元素

GridView.extent 快速创建纵轴子元素为固定最大长度

以上均会预先构建

GridView.builder 子元素较多时使用 同样需要指定 gridDelegate 与 itemBuilder

## CustomScrollView

使用 Sliver 自定义滚动模型组件，内部可以包含多种滚动模型，比如包含 LV 与 GV，并使其保持一致的滚动效果，就像粘合多个可滚动组件

> 暂时跳过

## 滚动监听控制

```dart
ScrollController({
  double initialScrollOffset = 0.0, //初始滚动位置
  this.keepScrollOffset = true,//是否保存滚动位置
  ...
})
```

- offset 可滚动组件当前滚动位置
- jumpTo(offset)
- animateTo(offset)
- ...

SC 间接继承自 Listenable，可以在上面监听滚动事件(`controller.addListener(()=>print(controller.offset))`)

### 恢复滚动位置

PageStroage 用于保存页面路由相关数据 使用方式是为 key 指定不同的 PageStorageKey，如`ListView(key: PageStorageKey(1))`，内部使用 bucket 存储

每次完成滚动（不是滚动到边界），都会存储滚动位置到 PS，当可滚动组件重新创建时再恢复，如果 SC.keepScrollOffset 为 false 就不会存储，重新创建时会使用 SC.initialScrollOffset（第一次会滚动到 initialScrollOffset），后续就会恢复先前存储的值。

当路由中存在多个需要保存滚动位置的控件时，就需要使用多个唯一的 PSK

> 不一定必须提供 PSK，可滚动组件本身就是 Stateful，其状态也会保存滚动位置，只要没有被卸载，state 就不会被销毁。当 Widget 发生了结构变化，导致可滚动组件的状态销毁，此时就需要显式指定 PSK，如 TabBarView 这种切换场景。

## ScrollPosition

用于保存可滚动组件滚动位置，一个 SC 可以被多个可滚动组件使用，SC 会为每一个可滚动组件创建一个 SP 对象，保存在 SC.positions 中，SC.offset 只是一个快速访问属性(`double get offset => position.pixels`)

在读取滚动位置时，就需要一对一进行操作，如`controller.positions.elementAt(0).pixels`

- animateTo
- JumpTo

> 这两个方法实际也来自于 SP

```dart
ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition);
void attach(ScrollPosition position) ;
void detach(ScrollPosition position) ;
```

当 SC 关联到一个可滚动组件，会首先调用 create 方法，创建滚动位置信息，然后 attach，将 SP 添加到 positions 中，也就是注册位置，只有在注册位置后才能调用 to 方法

**SC 的 animateTo 和 jumpTo 会调用所有 SP 的 a2 与 j2 方法来确保所有关联组件都滚动到指定位置**

## 滚动监听

子组件发送通知（Notification），父组件通过 NotificationListener 监听关注通知，就像事件冒泡一样。

可滚动组件在滚动时会发送 ScrollNotification 类型通知（ScrollBar 就是监听该通知实现的），通过 NL 与通过 SC 监听滚动事件的区别：

- 通过 NL 在可滚动组件上溯到根组件都能监听到，而 SC 需要和具体组件关联
- NL 在接收到事件后，事件中包括当前滚动位置和视口信息，而 SC 只包括当前滚动位置
