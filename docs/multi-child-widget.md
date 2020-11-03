# Multi-Child Layout Widgets

多子元素的控件

## Column

在垂直方向展示子组件，可以将单个子元素包裹在Expanded内来使其占据所有额外控件

默认下Column不会滚动，需要使用ListView来支持这种情况

## Flow



## GridView

在二维方向上进行布局，自带滚动能力

常用 .count方法 构建固定数量的项目

.extent 创建尽可能占满纵轴的项目布局

## IndexedStack

展示一组子控件的Stack，按照index属性决定当前渲染子控件

一次只显示一个，但会保存所有子项状态



## ListBody



## ListView

可控制滚动方向、滚动顺序（从下到上？）、可否滚动、是否保持子控件状态，常用.builder方法构建数量多的列表,separted构建列表之间带分隔项的、

## Row



## Stack

依次叠加子控件，使用fit属性控制如何适配未定位的子节点（默认为StackFit.loose），默认从左上角开始

可设置对齐属性，使用Positioned子组件进行定位，使用overflow控制超出情况

## Table

实际上是一种布局控件，在内部使用TableRow、TableColumn控制

## Wrap

为子组件超出可视区时自动换行


