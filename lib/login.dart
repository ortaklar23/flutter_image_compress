import 'package:flutter/material.dart';
import 'package:picture_compression/main.dart';
import 'package:picture_compression/register.dart';

class Login extends StatelessWidget {
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
        title: Text("Giriş Yap"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 55.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            child: ListView(
              children: <Widget>[
                Text(
                  "Giriş Yapmak için aşağıdaki bilgileri girin.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0)),
                    labelText: "Kullanıcı Adı: ",
                    prefixIcon: Icon(Icons.account_circle_rounded),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0)),
                      labelText: "Şifre: ",
                      prefixIcon: Icon(Icons.lock_rounded)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                    ),
                    child: Center(
                      child: Text(
                        "Giriş Yap",
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
                  height: 40.0,
                ),
                Center(
                  child: Text(
                    "Bir hesabınız yok mu?",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Register(),
                        ),
                      );
                    },
                    child: Text(
                      "Kayıt Ol!",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BilgiAlButonu(),
    );
  }
}
