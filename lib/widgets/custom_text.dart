import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontStyle? style;
  final TextAlign? align;
  final FontWeight? weight;
  const MyText(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.weight,
      this.align,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontStyle: style,
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
