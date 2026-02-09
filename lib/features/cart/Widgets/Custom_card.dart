import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Shared/Custom_button.dart';
import 'package:gap/gap.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.image,
    required this.title,
    required this.disc,
    required this.num,
    this.onadd,
    this.onmin,
    this.remove,
    this.isloadingremove,
  });

  final String image;
  final String title;
  final String disc;
  final int num;
  final Function()? onmin;
  final Function()? onadd;
  final Function()? remove;
  final bool? isloadingremove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1,
        color: Colors.white,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.network(image, height: 110),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          disc,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 40,
                        width: 39,

                        child: IconButton(
                          onPressed: onmin,
                          icon: Icon(CupertinoIcons.minus, color: Colors.white),
                        ),
                      ),
                      Gap(20),
                      Text(
                        num.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Gap(20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 40,
                        width: 39,
                        child: IconButton(
                          onPressed: onadd,
                          icon: Icon(CupertinoIcons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Gap(35),
                  isloadingremove == true
                      ? CupertinoActivityIndicator()
                      : CustomButton(Title: "    Remove    ", onTap: remove),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
