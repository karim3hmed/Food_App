import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_color.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(10),
        SvgPicture.asset(
          "assets/logo/logo.svg",

          // ignore: sort_child_properties_last, deprecated_member_use
          color: AppColor.primary,
        ),
        Spacer(),
        CircleAvatar(
          child: Icon(CupertinoIcons.person, color: Colors.white, size: 40),
          radius: 33,
          backgroundColor: AppColor.primary,
        ),
      ],
    );
  }
}
