import 'package:flutter/material.dart';

class CustomRowCheckout extends StatelessWidget {
  const CustomRowCheckout({
    super.key,
    required this.title,
    required this.value,
    this.fontWeight,
    this.color,
    this.size,
  });
  final String title;
  final String value;
  final FontWeight? fontWeight;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size ?? 20,
            color: color ?? Color(0xff7D7D7D),
            fontWeight: fontWeight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: size ?? 20,
            color: color ?? Color(0xff7D7D7D),
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
