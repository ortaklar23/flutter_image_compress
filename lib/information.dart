import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Bilgi / Yardım"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                Text(
                  "Bu Uygulama Fırat Üniversitesi Yazılım" +
                      "mühendisliği öğrencilerinden olan\n\nBahadır Sevim," +
                      "\nAzad Erdoğan,\nSemih Yücel,\nEnes Yılmaz\n\ntarafından" +
                      " ileri programlama teknikleri dersi için hazırlanmıştır.",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
