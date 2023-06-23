// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AdayWidget extends StatelessWidget {
  final int oySayisiAday;
  final bool oySayisiGonder;
  final VoidCallback onDecreaseAday;
  final VoidCallback onIncreaseAday;

  const AdayWidget({
    required this.oySayisiAday,
    required this.oySayisiGonder,
    required this.onDecreaseAday,
    required this.onIncreaseAday,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            IconButton(
              iconSize: 50,
              color: Colors.red,
              onPressed:
                  oySayisiAday > 0 && oySayisiGonder ? onDecreaseAday : null,
              icon: const Icon(Icons.remove),
            ),
            Text(
              '$oySayisiAday',
              style: const TextStyle(fontSize: 35),
            ),
            IconButton(
              iconSize: 50,
              color: Colors.blue,
              onPressed: oySayisiGonder ? onIncreaseAday : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
