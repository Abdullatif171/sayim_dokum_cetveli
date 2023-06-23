// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ZarfWidget extends StatelessWidget {
  final int zarfSayisi;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final bool onGonder;
  final VoidCallback onSend;

  const ZarfWidget({
    Key? key,
    required this.zarfSayisi,
    required this.onDecrease,
    required this.onIncrease,
    required this.onGonder,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/zarf.jpg'),
        Container(
          color: Colors.white,
          alignment: AlignmentDirectional.center,
          width: 180,
          height: 80,
          child: Text(
            "Zarf Sayisi: $zarfSayisi",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 55),
            IconButton(
                iconSize: 50,
                color: Colors.red,
                onPressed: zarfSayisi > 0 && onGonder ? onDecrease : null,
                icon: const Icon(Icons.remove)),
            const SizedBox(width: 150),
            IconButton(
              iconSize: 50,
              color: Colors.blue,
              onPressed: onGonder ? onIncrease : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onGonder ? onSend : null,
          child: const Text('Sayımı Bitir'),
        ),
      ],
    );
  }
}
