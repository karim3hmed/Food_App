import 'package:flutter/material.dart';

class SideOptionsCart extends StatelessWidget {
  const SideOptionsCart({
    super.key,
    required this.image,
    this.onTap,
    required this.name,
  });
  final String image;
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 12,
                offset: Offset(0, 10),
              ),
            ],
            color: Color(0xff3C2F2F),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Image.asset(
                        "assets/icons/Group23.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          height: 60,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Image.network(image, fit: BoxFit.contain),
        ),
      ],
    );
  }
}
