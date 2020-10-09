# 布局

## 线性布局

> Row与Column均继承于Flex

### Row

水平方向排列, 主轴为横轴

控制:

- textDirection 布局顺序
- mainAxisSize 主轴占用空间, 默认为占满, 为min时主轴宽度等于所有子组件实际占用的水平空间
- mainAxisAlignment 水平对齐方式, 仅当axisSize为max时有意义, 以textDirection作为参考系
- verticalDirection 纵轴对齐方向
- crossAixsAlignment 纵轴对齐方式, 顶部/底部对齐等

### Column

类比为Row

Row与Column都只会在主轴占用尽可能大空间(只可设置主轴空间), 对于纵轴的长度取决于其最大子元素长度.

Row / Column的内部多次嵌套, 只有最外层的Row/Column会占用尽可能多空间, 而内部的Row/Column占用空间为实际大小.

## Flex

通常和Expanded配合

是Row/Column父类

## Expanded

可以按比例进行扩充弹性布局控件占用空间(使用其flex参数)

是所有的Expanded按照大家的flex属性进行计算比例

Spacer控件: Expanded的包装类 用于占用指定比例空间

## Wrap

Row/Column的溢出不会自动换行, 默认只有一行

可以认为Wrap和Flex的区别就是超出显示范围后自动折行

- spacing 主轴方向子组件间距
- runSpacing 纵轴方向子组件间距
- runAlignment 纵轴方向子组件对齐方式

## Flow

使用较少, 因为较复杂, 需要自己实现子组件位置转换啥的.
用于需要自定义布局或性能要求高的场景

## 层叠布局

### Stack

类似于CSS绝对定位

- alignment 如何对齐非Positioned控件, 或者是使用了但没有在LTRB任意一轴上定位的子组件.
- fit 非Positioned控件如何适应Stack大小, loose表示使用子组件大小, expand表示扩张适应Stack
- overflow 如何显示超出的子控件

### Positioned

L T R B W H

搭配:

```dart
ConstrainedBox(
  constraints: BoxConstraints.expand(),
  child: Stack(
  alignment:Alignment.center ,
  fit: StackFit.expand, //未定位widget占满Stack整个空间
  children: <Widget>[
    Positioned(
      left: 18.0,
      child: Text("I am Jack"),
    ),
    Container(child: Text("Hello world",style: TextStyle(color: Colors.white)),
      color: Colors.red,
    ),
    Positioned(
      top: 18.0,
      child: Text("Your friend"),
    )
  ],
),
);
```

## Align

较简单的调节子元素在父元素中的位置

- alignment 定位位置
- width/heightFactor 缩放因子 如果为null 会尽可能占用多控件

Align 需要通过alignment确定坐标原点
Stack / Positioned 的参考系则可以是父容器矩形顶点

### Alignment

Alignment(this.x, this.y)

## Center

继承自Align, 实际上是对齐方式确定为Alignment.center的Align控件

剧中组件, 另外一种实现居中的方式是使用ConstrainedBox或SizedBox强制将Column宽度设为屏幕宽度:

```dart
ConstrainedBox(
  constraints: BoxConstraints(minWidth: double.infinity),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text("hi"),
      Text("world"),
    ],
  ),
);
```

