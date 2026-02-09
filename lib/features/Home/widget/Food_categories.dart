import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
class Foodgategories extends StatefulWidget {
   Foodgategories({super.key,required this.categories ,required this.selectedindex });

  final int selectedindex;
 final  List categories;

  @override
  State<Foodgategories> createState() => _FoodgategoriesState();


}

class _FoodgategoriesState extends State<Foodgategories> {
 late int selectedindex;
  @override
  void initState() {
    setState(() {
      selectedindex = widget.selectedindex;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
             selectedindex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 9),
              // ignore: sort_child_properties_last
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              // ignore: sort_child_properties_last
              child: Text(
               widget.categories[index],
                style: TextStyle(
                  color:selectedindex == index
                      ? Colors.white
                      : Color(0xff6A6A6A
                  ),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:selectedindex == index
                    ? AppColor.primary
                    : Color(0xfff3f4f6),
              ),
            ),
          );
        }),
      ),
    );
  }
}
