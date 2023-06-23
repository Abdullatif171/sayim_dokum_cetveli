// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/anasayfa.dart';
import 'package:flutter_application_1/ZarfWidget.dart';
import 'package:flutter_application_1/adaywidget.dart';
import 'package:flutter_application_1/sonucwidget.dart';

List<String> titles = <String>[
  'Zarf Say',
  'Oy Say',
  'Sonuç',
];

class M_Sayim extends StatefulWidget {
  const M_Sayim({Key? key}) : super(key: key);

  @override
  State<M_Sayim> createState() => _M_SayimState();
}

class _M_SayimState extends State<M_Sayim> {
  int oySayisiAday1 = 0;
  int oySayisiAday2 = 0;
  int gecersizOy = 0;
  int zarfSayisi = 0;
  int tabsCount = 3;
  String sonuc = "Sonuç";

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
            title: const Text("Seçim Sayacı"),
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AnaSayfa()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
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
                  onReset: () {
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
