import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
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
  ImageStatus imageStatus = ImageStatus.ANY;

  Uint8List compressedImage;
  double quality = 10;
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
                onTap: () {
                  downloadImage();
                },
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

  InkWell buildInkWellButton(BuildContext context,
      {String text, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: 260.0,
        decoration: BoxDecoration(
          color: Colors.red[700],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Center buildCircleAvatar() {
    return Center(
      child: CircleAvatar(
        child: _image == null ? Text("Fotoğraf") : null,
        radius: 90.0,
        backgroundColor: Colors.orange[600],
        backgroundImage: _image != null ? FileImage(_image) : null,
      ),
    );
  }

  Text buildTextButton({String buttonText}) {
    return Text(
      buttonText,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
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

  Future<Uint8List> compressAndGetFile(File file) async {
    print("testCompressAndGetFile");
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 80,
      minWidth: 1024,
      minHeight: 1024,
      rotate: 0,
    );
    print('on compresed');
    print(file.lengthSync());
    print(result.length);
    setState(() {
      imageStatus = ImageStatus.COMPRESSED;
      compressedImage = result;
    });
    return result;
  }

  void _cropImage(File image) async {
    File cropedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 800,
    );
    /*     Directory dir = await getTemporaryDirectory();
                      print(dir.absolute.path);
                      final targetPath = dir.absolute.path + "/temp.jpg";
                      testCompressAndGetFile(cropedImage, targetPath); */
    if (cropedImage != null) {
      setState(() {
        _image = cropedImage;
      });
    }
    compressAndGetFile(cropedImage);
    print('  on croped');
    print(cropedImage.lengthSync());
    print(cropedImage.absolute.path);
  }

  void loadSelected(ImageSource source) async {
    final picker = ImagePicker();
    final selected = await picker.getImage(source: source);
    setState(() {
      if (selected != null) {
        // _image = File(selected.path);
        _cropImage(File(selected.path));
        imageStatus = ImageStatus.UPLOAD;
      }
    });
    Navigator.pop(context);
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  _save() async {
    if (await _requestPermission(Permission.storage)) {
      print(compressedImage);
      final result = await ImageGallerySaver.saveImage(
        compressedImage,
        quality: quality.toInt(),
        name: "compressedImage",
      );
      print('Saved');

      print(result);
    }
  }

  void downloadImage() async {
    _save();
  }
}

enum ImageStatus { ANY, UPLOAD, COMPRESSED, DOWNLOADED }
