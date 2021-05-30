import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_compression/login.dart';
import 'package:picture_compression/main.dart';
import 'package:picture_compression/prof.dart';

import 'basic.dart';

class Selection extends StatelessWidget {
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
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bir mod seçiniz",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 25.0,
                  fontFamily: 'Oswald',
                ),
              ),
              Divider(
                color: Colors.red[800],
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) => Basic()));
                },
                child: Container(
                  height: 45.0,
                  width: 260.0,
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                  ),
                  child: Center(
                    child: Text(
                      "Basic",
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
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) => ProffesionalCompress()));
                },
                child: Container(
                  height: 45.0,
                  width: 260.0,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                  ),
                  child: Center(
                    child: Text(
                      "Professional",
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
                height: 45.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BilgiAlButonu(),
    );
  }
}
