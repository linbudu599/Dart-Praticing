# 容器

> 容器控件并不是只有Container 个人理解Padding甚至Clip都是容器
> 只不过Container是没有封装任何功能的容器

## Padding

类似于Container+padding, 但它不是继承自Container类, 而是SingleChildRenderObjectWidget类.

## Size Limit

勇于尺寸限制

### ConstrainedBox

见demo  主要限制最小最大宽高

多个父级CB限制下, 最小约束是取多重限制中较大的, 最大约束取较小的

#### UnconstrainedBox

用于"去除"父级CB限制:

```dart
ConstrainedBox(
    constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),  //父
    child: UnconstrainedBox( //“去除”父级限制
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
        child: redBox,
      ),
    )
)
```

最终会按照子CB限制绘制出90*20, 但上方会有80的空白, 只是不影响子元素(红盒子大小)

可以认为父级CB现在作用于子UB上, 子元素现在只受到子CB限制

### FractionallySizedBox

根据父容器宽高百分比设置子组件宽高

### SizedBox

见demo  指定固定宽高

SizedBox 是 CB 的一个特殊定制:

```dart
ConstrainedBox(
  constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
  child: redBox, 
)
// 一样
BoxConstraints(minHeight: 80.0,maxHeight: 80.0,minWidth: 80.0,maxWidth: 80.0)
```

等价于使用SizebBox指定宽高为80

二者都是通过RenderConstrainedBox

## DecoratedBox

- decoration 定义具体装饰 通常直接使用BoxDecoration类
- position DecorationPosition.foreground/background 绘制位置 前景/背景

## Transform

对子组件应用矩阵变换(2D/3D效果) 暂时跳过

旋转 / 缩放 / 放大

## Container

一个组合类容器,实际上包含了前面提到的那些功能, 即可以通过Container来实现装饰 / 变换 / 尺寸限制能力.

Container的margin与padding都是通过Padding组件实现的:

```dart
Container(
  margin: EdgeInsets.all(20.0), //容器外补白
  color: Colors.orange,
  child: Text("Hello world!"),
),
Container(
  padding: EdgeInsets.all(20.0), //容器内补白
  color: Colors.orange,
  child: Text("Hello world!"),
),

// 相当于
Padding(
  padding: EdgeInsets.all(20.0),
  child: DecoratedBox(
    decoration: BoxDecoration(color: Colors.orange),
    child: Text("Hello world!"),
  ),
),
DecoratedBox(
  decoration: BoxDecoration(color: Colors.orange),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text("Hello world!"),
  ),
),
```

## 裁剪

ClipOval 子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
ClipRRect 裁剪为圆角矩形
ClipRect 裁剪到实际占用矩形大小

### 自定义裁剪

基于CustomClipper创建自定义裁剪类

> 裁剪在layout完成后的绘制阶段进行, 不会影响组件大小

```dart
class MyClipper extends CustomClipper<Rect> {
    
  @override
  // 获取裁剪区域接口
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  // 是否重新裁剪
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
```