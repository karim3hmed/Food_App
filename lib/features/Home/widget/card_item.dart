import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.rate,
  });

  final String image;
  final String title;
  final String desc;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.network(
                image,
                width: 125,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(19),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title.split(" ")[0] + "\n", // أول كلمة
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: title.split(" ").skip(1).join(" "), // باقي الكلمات
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Text(
              "⭐️ $rate",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
