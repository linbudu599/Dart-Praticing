import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<File> _imageList = [];
  File _image;
  final ImagePicker picker = ImagePicker();

  Future getImage([bool shouldOpenCamera = true]) async {
    Navigator.pop(context);

    final pickedFile = await picker.getImage(
        source: shouldOpenCamera ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _imageList.add(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
          child: Wrap(spacing: 5, runSpacing: 5, children: _genImages())),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _pickImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            height: 160,
            child: Column(
              children: <Widget>[
                _item("拍照", true),
                _item("从相册选择", false),
              ],
            )));
  }

  Widget _item(String title, bool shouldOpenCamera) {
    return GestureDetector(
        child: ListTile(
      leading: Icon(shouldOpenCamera ? Icons.camera_alt : Icons.photo_library),
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: () => getImage(shouldOpenCamera),
    ));
  }

  List<Widget> _genImages() {
    return _imageList.map((file) {
      return Stack(children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(file, width: 120, height: 90, fit: BoxFit.fill)),
        Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _imageList.remove(file);
                  });
                },
                child: ClipOval(
                    child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.black54),
                        child:
                            Icon(Icons.close, size: 17, color: Colors.white)))))
      ]);
    }).toList();
  }
}
