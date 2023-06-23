// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../button.dart';

class SonucWidget extends StatefulWidget {
  final int oySayisiAday1;
  final int oySayisiAday2;
  final int zarfSayisi;
  final int gecersizOy;
  String sonuc;
  VoidCallback onCheck;
  VoidCallback onReset;

  SonucWidget({
    required this.oySayisiAday1,
    required this.oySayisiAday2,
    required this.zarfSayisi,
    required this.gecersizOy,
    required this.sonuc,
    required this.onReset,
    required this.onCheck,
  });

  @override
  _SonucWidgetState createState() => _SonucWidgetState();
}

class _SonucWidgetState extends State<SonucWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              width: 130,
              height: 80,
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Aday 1: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    " ${widget.oySayisiAday1}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: 130,
              height: 80,
              alignment: AlignmentDirectional.center,
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Aday 2: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "${widget.oySayisiAday2}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: 130,
              height: 80,
              alignment: AlignmentDirectional.center,
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Geçersiz Oy Sayısı: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "${widget.gecersizOy}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 30,
          color: Colors.black,
        ),
        SizedBox(
          height: 30,
          child: Text(
            "Toplam Oy Sayısı: ${widget.oySayisiAday1 + widget.oySayisiAday2 + widget.gecersizOy}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          height: 30,
          color: Colors.black,
        ),
        SizedBox(
          height: 30,
          child: Text(
            "Zarf Sayısı: ${widget.zarfSayisi}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          height: 30,
          color: Colors.black,
        ),
        MyButton(widget.sonuc, 30, 250, 50, Colors.black, 10, widget.onCheck),
        const SizedBox(height: 20),
        MyButton(
            "Sayım Tekrarı", 30, 250, 50, Colors.black, 10, widget.onReset),
      ],
    );
  }
}
