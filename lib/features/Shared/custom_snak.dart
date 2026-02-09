import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

SnackBar customSnak(message, Color color) {
  return SnackBar(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: EdgeInsets.only(bottom: 25, right: 20, left: 20),
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    backgroundColor: color,

    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(10),
        Text(
          message.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
