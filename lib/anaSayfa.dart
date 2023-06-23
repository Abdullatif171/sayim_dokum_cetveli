// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'button.dart';
import 'kullanici_Sayfalari/kullaniciGiris.dart';
import 'misafirSayfalari/M_Sayim.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  //check internet connected
  bool isDeviceConnected = true;
  //if we haven't internet open showDialogBox Func or open UserOpenPage
  Future<void> checkInternetConnection() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected) {
      showDialogBox();
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserOpenPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Hakkında'),
                    content: SizedBox(
                      height: 150,
                      child: Column(
                        children: const [
                          Text(
                              'Bu uygulama 2023 Cumhur Başkanlığı seçimlerinde Kullanılmak Üzere Gönüllülük esası ile Hazırlanmıştır.'),
                          Text("\nlatif Tarafından hazırlanmıştır")
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.question_mark),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("SAYIM DÖKÜM \nCETVELİ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    MyButton("Kullanıcı Girişi", 15, 250, 40, Colors.blue, 25,
                        () {
                      checkInternetConnection();
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyButton(
                        "Misafir Olarak Devam Et", 15, 250, 40, Colors.blue, 25,
                        () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => M_Sayim()),
                        (Route<dynamic> route) => false,
                      );
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
