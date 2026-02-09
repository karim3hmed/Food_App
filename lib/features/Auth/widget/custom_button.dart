import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.textcolor,
  });
  final String title;
  final Function()? onTap;
  final Color? color;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // ignore: sort_child_properties_last
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textcolor ?? AppColor.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(18),
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
