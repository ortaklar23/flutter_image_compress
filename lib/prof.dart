import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:picture_compression/main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProffesionalCompress extends StatefulWidget {
  @override
  _ProffesionalCompressState createState() => _ProffesionalCompressState();
}

class _ProffesionalCompressState extends State<ProffesionalCompress> {
  ImageStatus imageStatus = ImageStatus.ANY;

  File _image;
  Uint8List compressedImage;
  double quality = 10;
  @override
  Widget build(BuildContext context) {
    var compressOnTap = () async {
      switch (imageStatus) {
        case ImageStatus.COMPRESSED:
          downloadImage();
          break;
        case ImageStatus.UPLOAD:
          compressedImage = await compressAndGetFile(_image);
          break;
        default:
      }
    };
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text("Profesyonel"),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          buildCircleAvatar(),
          SizedBox(height: 20),
          buildInkWellButton(
            context,
            text: 'Fotoğraf Yükle',
            onTap: () {
              _askSelectedImage(context);
            },
          ),
          SizedBox(height: 20),
          buildSlider(),
          buildInkWellButton(
            context,
            text: imageStatus == ImageStatus.UPLOAD
                ? 'Fotoğraf Sıkıştır'
                : "Fotoğrafı indir",
            onTap: compressOnTap,
          ),
          SizedBox(height: 20),
        ],
      ),
      floatingActionButton: BilgiAlButonu(),
    );
  }

  Slider buildSlider() {
    return Slider(
      value: quality,
      onChanged: (value) {
        setState(() {
          quality = value;
        });
      },
      divisions: 4,
      max: 100,
      min: 0,
      label: "$quality",
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
      quality: 10,
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
