# websocket

连接到WebSocket服务器

监听来自服务器的消息

将数据发送到服务器

关闭WebSocket连接

使用web_socket_channel包:

```dart
final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

new StreamBuilder(
  stream: widget.channel.stream,
  builder: (context, snapshot) {
    return new Text(snapshot.hasData ? '${snapshot.data}' : '');
  },
);

// 发送数据
// StreamSink类
channel.sink.add('Hello!');

channel.sink.close();
```

使用ws接收二进制数据:

> 要接收二进制数据仍然使用StreamBuilder，因为WebSocket中所有发送的数据使用帧的形式发送，而帧是有固定格式，每一个帧的数据类型都可以通过Opcode字段指定，它可以指定当前帧是文本类型还是二进制类型（还有其它类型），所以客户端在收到帧时就已经知道了其数据类型，所以flutter完全可以在收到数据后解析出正确的类型，所以就无需开发者去关心，当服务器传输的数据是指定为二进制时，StreamBuilder的snapshot.data的类型就是List<int>，是文本时，则为String。