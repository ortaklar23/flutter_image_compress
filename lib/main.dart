import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_compression/information.dart';
import 'package:picture_compression/login.dart';
import 'package:picture_compression/selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Görsel Sıkıştırma',
      home: Welcome(),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200.0, left: 45.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "HOŞGELDİNİZ!",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Oswald',
                ),
              ),
            ),
            Container(
              child: Text(
                "GÖRÜNTÜ SIKIŞTIRMA PROGRAMI",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 12.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => Selection(),
                  ),
                );
              },
              child: Container(
                height: 45.0,
                width: 260.0,
                decoration: BoxDecoration(
                  color: Colors.red[700],
                ),
                child: Center(
                  child: Text(
                    "Fotoğraf Sıkıştır",
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
              height: 12.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                );
              },
              child: Container(
                height: 45.0,
                width: 260.0,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                ),
                child: Center(
                  child: Text(
                    "Giriş Yap!",
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
      floatingActionButton: BilgiAlButonu(),
    );
  }
}

class BilgiAlButonu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red[700],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Information(),
          ),
        );
      },
      child: Icon(Icons.info_outline),
    );
  }
}
