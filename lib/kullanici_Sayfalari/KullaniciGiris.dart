// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, file_names, camel_case_types, use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../anaSayfa.dart';
import '../button.dart';
import '../kullanici_Sayfalari/K_Sayim.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final firebaseAuth = FirebaseAuth.instance;
String Kullanici = "Kullanici Girisi";

class UserOpenPage extends StatefulWidget {
  const UserOpenPage({super.key});

  @override
  State<UserOpenPage> createState() => _UserOpenPageState();
}

class _UserOpenPageState extends State<UserOpenPage> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController SandikNo = TextEditingController();
  String? userUid;
  var _isObscured = true;
  bool isDeviceConnected = true;

  Future<void> checkInternetConnection() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected) {
      showDialogBox();
    } else {
      await GirisYap();
    }
  }

//Dialog box for checking internet connection
  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bağlantı Yok'),
          content: const Text('İnternet bağlantınızı kontrol edin.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

//Dialog box for checking e-mail or password
  void showDialogBox1(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  Future<void> GirisYap() async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: Email.text,
        password: Password.text,
      );

      final user = userCredential.user;

      if (user != null) {
        setState(() {
          userUid = user.uid; // userUid'i ayarla
        });

        await FirebaseFirestore.instance.collection(Kullanici).doc(userUid).set(
          {
            'SandikNo': SandikNo.text,
            'Email': Email.text,
            'pasword': Password.text,
            'Kemal Kılıççdaroğlu': 0,
            'Recep Tayyip Erdoğan': 0,
            'zarf Sayisi': 0,
            'Geçersiz Oy': 0,
            'toplam Oy Sayisi': 0,
          },
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => K_Sayim(uid: userUid),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      showDialogBox1("Hata", "E-posta veya şifre yanlış.");
      return; // Add a return statement here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kullanici Girisi"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AnaSayfa()),
                      (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.home))
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Sandık No:',
                        ),
                        controller: SandikNo),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email:',
                        ),
                        controller: Email),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              padding: EdgeInsetsDirectional.only(end: 12.0),
                              icon: _isObscured
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              }),
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                        ),
                        obscureText: _isObscured,
                        controller: Password),
                    SizedBox(
                      height: 10,
                    ),
                    MyButton("Giriş Yap", 15, 250, 40, Colors.blue, 25, () {
                      checkInternetConnection();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
