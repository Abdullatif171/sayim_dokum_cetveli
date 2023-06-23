// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text;
  double width;
  double height;
  double fontsize;
  double circular;
  Color color;
  VoidCallback OnPressed;

  MyButton(this.text, this.fontsize, this.width, this.height, this.color,
      this.circular, this.OnPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(circular)),
      child: MaterialButton(
        onPressed: OnPressed,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(circular)),
        color: color,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontsize),
        ),
      ),
    );
  }
}
