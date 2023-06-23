// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'anaSayfa.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hata ayıklama bandını (debug banner) göstermemek için kullanılır.
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(), // AnaSayfa.dart uygulamanın ana ekranı olarak belirler.
    );
  }
}
