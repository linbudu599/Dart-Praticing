import "package:flutter/material.dart";
import "dart:io";
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDemo extends StatefulWidget {
  ImageDemo({Key key}) : super(key: key);

  @override
  _ImageDemoState createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo> {
// 加载相对路径本地图片
//Image.file(File('/sdcard/Download/Stack.png')),
// FutureBuilder(future: _getLocalFile("Download/Stack.png"),
//   builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//     return snapshot.data != null ? Image.file(snapshot.data) : Container();
//   })
//   )
//   //获取SDCard的路径：
//  Future<File> _getLocalFile(String filename) async {
//     String dir = (await getExternalStorageDirectory()).path;
//     File f = new File('$dir/$filename');
//     return f;
//   }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image(
              width: 100,
              height: 100,
              image: NetworkImage(
                  "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif")),

          // 牛批啊
          Stack(
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    width: 100,
                    height: 100,
                    image:
                        "https://linbudu-img-store.oss-cn-shenzhen.aliyuncs.com/img/48507806.jfif"),
              ),
            ],
          ),
          CachedNetworkImage(
            placeholder: (context, url) => new CircularProgressIndicator(),
            imageUrl: 'https://picsum.photos/250?image=9',
          ),
        ],
      ),
    );
  }
}
