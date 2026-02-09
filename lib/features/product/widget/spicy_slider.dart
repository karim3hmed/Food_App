import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:gap/gap.dart';

class SpicySlider extends StatelessWidget {
  SpicySlider({super.key, required this.value, this.onChanged});
  final double value;
  final Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/detail/sandwich.png", width: 217, height: 297),

        Expanded(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customize",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(" Your Burger \n "),
                    ],
                  ),
                  Text("to Your Tastes. Ultimate\n Experience"),
                ],
              ),
              Gap(10),
              Slider(
                min: 0,
                max: 100,
                value: value,
                onChanged: onChanged,
                activeColor: AppColor.primary,
                inactiveColor: Colors.grey.shade300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/icons/🥶.png"),
                    Image.asset("assets/icons/🌶️.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
