import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picture_compression/main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Basic extends StatefulWidget {
  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("Basic"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              CircleAvatar(
                child: _image == null ? Text("Fotoğraf") : null,
                radius: 90.0,
                backgroundColor: Colors.orange[600],
                backgroundImage: _image != null ? FileImage(_image) : null,
              ),
              SizedBox(
                height: 70.0,
              ),
              InkWell(
                onTap: () {
                  _askSelectedImage(context);
                },
                child: Container(
                  height: 45.0,
                  width: 260.0,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                  ),
                  child: Center(
                    child: Text(
                      "Fotoğraf Yükle",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 45.0,
                  width: 260.0,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                  ),
                  child: Center(
                    child: Text(
                      "Fotoğrafı İndir!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BilgiAlButonu(),
    );
  }

  void _askSelectedImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Galeriden fotoğraf seç"),
                    onTap: () {
                      loadSelected(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    title: Text("Kameradan fotoğraf çek"),
                    onTap: () {
                      loadSelected(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ));
  }

  void _cropImage(File image) async {
    File cropedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 800,
    );
    Directory dir = await getTemporaryDirectory();
    print(dir.absolute.path);
    final targetPath = dir.absolute.path + "/temp.jpg";
    testCompressAndGetFile(cropedImage, targetPath);
    if (cropedImage != null) {
      setState(() {
        _image = cropedImage;
      });
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void loadSelected(ImageSource source) async {
    final picker = ImagePicker();
    final selected = await picker.getImage(source: source);
    setState(() {
      if (selected != null) {
        // _image = File(selected.path);
        _cropImage(File(selected.path));
      }
    });
    Navigator.pop(context);
  }
}
