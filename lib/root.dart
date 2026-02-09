import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Auth/views/profile_view.dart';
import 'package:foodapp/features/Home/Views/Home_view.dart';
import 'package:foodapp/features/cart/Views/Cart_view.dart';
import 'package:foodapp/features/orderHistory/View/order_History_View.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late List<Widget> screen;
  late PageController controller;
  int currentscreen = 0;

  @override
  void initState() {
    screen = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        // ignore: sort_child_properties_last
        children: screen,
        physics: NeverScrollableScrollPhysics(),
      ),

      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: "History",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade500,
          currentIndex: currentscreen,
          onTap: (index) {
            setState(() {
              currentscreen = index;
            });
            controller.jumpToPage(currentscreen);
          },
        ),
      ),
    );
  }
}
