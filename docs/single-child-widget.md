# 单子元素

## Align

用于对齐内部的子控件（控制对齐方向，如上、左上等），并且可以根据子元素的尺寸调整Align控件的尺寸。

感觉Center就像是alignment被设置为center的Align，aligment还可以传入精确的两个double值（以左下角为原点，从下至上为1到-1，从左到右为-1到1）

通过heightFactor与widthFactor来根据子控件设置Align的大小



## AspectRadio

尝试将子元素尺寸设置为一定比例。

首先尝试最大宽度：来自layout的限制，高度由比例决定

`aspectRatio: 3/2` （长 / 宽）

如果被包裹在Expanded控件下，会被强制扩展，可以通过在二者之间新增Align控件，Expanded控件会对填充区域来强制扩展



## Baseline

## Expanded

用于扩展Row、Column、Flex组件，使得子组件能够被扩充以获得所需的控件

比如在三个space-around的子组件中，为中间的组件使用Expanded来使得其扩展占据剩余空间

使用flex属性来分配空间，多个Expanded组件按照各自的flex属性进行分配



## FittedBox

当子组件与父组件尺寸不贴合时，设置如何去修正子组件使其贴合

fit：BoxFit 缩放/裁剪子组件

alignment：有多余空间时如何对齐



## FractionallySizedBox

从总可用的空间中进行分配，就像内外边距、宽高的百分比属性

widthFactor、heightFactor

可以在外层再用一个Container+alignment属性来设置对齐方式

可以不传入子项来作为占位



## LimitedBox

在不受约束（unconstrained）的情况下限制尺寸

当一个控件没有被限制尺寸时使用给定的尺寸

也适用于列表子项没有被设置高度时不会被显示的情况

maxHeight

maxWidth



## Padding

当为Container设置padding属性时，其实内部就使用了Padding组件



## SizedBox

当传入了子元素，会使用指定的宽高进行限制子元素尺寸，如果子元素的尺寸依赖于父元素，那么宽高必须传入。

如果被设置为无限大，也只会就扩展到父级约束值（填充可用空间）

此时相当于使用.expand方法
