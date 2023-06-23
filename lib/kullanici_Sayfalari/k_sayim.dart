// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AnaSayfa.dart';
import '../kullanici_Sayfalari/kullaniciGiris.dart';
import '../ZarfWidget.dart';
import '../adaywidget.dart';
import '../sonucwidget.dart';

List<String> titles = <String>[
  'Zarf Say',
  'Oy Say',
  'Sonuç',
];

class K_Sayim extends StatefulWidget {
  final String? uid;
  const K_Sayim({Key? key, this.uid}) : super(key: key);

  @override
  State<K_Sayim> createState() => _K_SayimState();
}

class _K_SayimState extends State<K_Sayim> {
  int oySayisiAday1 = 0;
  int oySayisiAday2 = 0;
  int zarfSayisi = 0;
  int gecersizOy = 0;
  int tabsCount = 3;
  String sonuc = "Sonuç";

  Future<void> Update() async {
    FirebaseFirestore.instance.collection(Kullanici).doc(widget.uid).update({
      'zarf Sayisi': zarfSayisi,
      'Kemal Kılıççdaroğlu': oySayisiAday1,
      'Recep Tayyip Erdoğan': oySayisiAday2,
      'Geçersiz Oy': gecersizOy,
      'toplam Oy Sayisi': oySayisiAday1 + oySayisiAday2 + gecersizOy,
    });
  }

  bool zarfSayisiGonder = true;
  bool oySayisiGonder = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Sayima Başla"),
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            scrolledUnderElevation: 4.0,
            shadowColor: Theme.of(context).shadowColor,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: const Icon(Icons.mail_outline_sharp),
                  text: titles[0],
                ),
                Tab(
                  icon: const Icon(Icons.how_to_vote_sharp),
                  text: titles[1],
                ),
                Tab(
                  text: titles[2],
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then(
                          (value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AnaSayfa()),
                              (Route<dynamic> route) => false),
                        );
                  },
                  icon: const Icon(Icons.exit_to_app)),
            ],
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  ZarfWidget(
                    zarfSayisi: zarfSayisi,
                    onGonder: zarfSayisiGonder,
                    onDecrease: () {
                      if (zarfSayisi > 0 && zarfSayisiGonder) {
                        setState(() {
                          zarfSayisi -= 1;
                        });
                      }
                    },
                    onIncrease: () {
                      if (zarfSayisiGonder) {
                        setState(() {
                          zarfSayisi += 1;
                        });
                      }
                    },
                    onSend: () {
                      setState(() {
                        Update();
                        zarfSayisiGonder = false;
                      });
                    },
                  ),
                ],
              ),
              ListView(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Image.asset("assets/Aday1.jpg"),
                          ),
                          AdayWidget(
                            oySayisiAday: oySayisiAday1,
                            oySayisiGonder: oySayisiGonder,
                            onDecreaseAday: () {
                              if (oySayisiAday1 > 0 && oySayisiGonder == true) {
                                setState(() {
                                  oySayisiAday1 -= 1;
                                });
                              }
                            },
                            onIncreaseAday: () {
                              if (oySayisiGonder == true) {
                                setState(() {
                                  oySayisiAday1 += 1;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Image.asset("assets/gecersizOy.jpg"),
                          ),
                          AdayWidget(
                            oySayisiAday: gecersizOy,
                            oySayisiGonder: oySayisiGonder,
                            onDecreaseAday: () {
                              if (gecersizOy > 0 && oySayisiGonder == true) {
                                setState(() {
                                  gecersizOy -= 1;
                                });
                              }
                            },
                            onIncreaseAday: () {
                              if (oySayisiGonder == true) {
                                setState(() {
                                  gecersizOy += 1;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Image.asset("assets/Aday2.jpg"),
                          ),
                          AdayWidget(
                            oySayisiAday: oySayisiAday2,
                            oySayisiGonder: oySayisiGonder,
                            onDecreaseAday: () {
                              if (oySayisiAday2 > 0 && oySayisiGonder == true) {
                                setState(() {
                                  oySayisiAday2 -= 1;
                                });
                              }
                            },
                            onIncreaseAday: () {
                              if (oySayisiGonder == true) {
                                setState(() {
                                  oySayisiAday2 += 1;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Update();
                        oySayisiGonder = false;
                      });
                    },
                    child: const Text('Sayımı Bitir'),
                  ),
                ],
              ),
              ListView(children: [
                SonucWidget(
                  oySayisiAday1: oySayisiAday1,
                  oySayisiAday2: oySayisiAday2,
                  zarfSayisi: zarfSayisi,
                  gecersizOy: gecersizOy,
                  sonuc: sonuc,
                  onCheck: () {
                    if (zarfSayisi !=
                        oySayisiAday1 + oySayisiAday2 + gecersizOy) {
                      setState(() {
                        sonuc = "Sayım Yalnış";
                      });
                    } else {
                      setState(() {
                        sonuc = "Sayım Doğru";
                      });
                    }
                  },
                  onReset: () async {
                    await FirebaseFirestore.instance
                        .collection(Kullanici)
                        .doc(widget.uid)
                        .update(
                      {
                        'zarf Sayisi': 0,
                        'Kemal Kılıççdaroğlu': 0,
                        'Recep Tayyip Erdoğan': 0,
                        'Geçersiz Oy': 0,
                        'toplam Oy Sayisi': 0,
                      },
                    );

                    setState(() {
                      oySayisiAday1 = 0;
                      oySayisiAday2 = 0;
                      gecersizOy = 0;
                      zarfSayisi = 0;
                      zarfSayisiGonder = true;
                      oySayisiGonder = true;
                      sonuc = "Sonuç";
                    });
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
