// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Shared/Custom_button.dart';
import 'package:foodapp/features/Shared/custom_snak.dart';
import 'package:foodapp/features/cart/Widgets/Custom_card.dart';
import 'package:foodapp/features/checkout/Views/Check_out_view.dart';
import 'package:foodapp/features/product/data/cart_Repo.dart';
import 'package:foodapp/features/product/data/cart_model.dart';
// ignore: unnecessary_import
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities;
  late List<bool> isRemoving; // لكل عنصر حالة حذف
  CartRepo cartRepo = CartRepo();
  GetCartResponse? cartResponse;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getcartdata();
  }

  Future<void> getcartdata() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await cartRepo.GetCartData();
      setState(() {
        cartResponse = response;
        quantities = List.generate(
          cartResponse?.cartData.items.length ?? 0,
          (index) => 1,
        );
        isRemoving = List.generate(
          cartResponse?.cartData.items.length ?? 0,
          (index) => false,
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        customSnak("${e.toString()} , please try again", Colors.red),
      );
    }
  }

  Future<void> removeCartItem(int index, int id) async {
    setState(() {
      isRemoving[index] = true; // شغل الـ indicator للعنصر ده فقط
    });

    try {
      await cartRepo.RemoveCartItem(id);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(customSnak("Item removed", Colors.green));
      await getcartdata(); // تحديث القائمة بعد الحذف
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(customSnak(e.toString(), Colors.red));
    } finally {
      if (index < isRemoving.length) {
        setState(() {
          isRemoving[index] = false;
        });
      }
    }
  }

  void onAdd(int index) {
    if (index < quantities.length) {
      setState(() {
        quantities[index]++;
      });
    }
  }

  void onMin(int index) {
    if (index < quantities.length && quantities[index] > 1) {
      setState(() {
        quantities[index]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CupertinoActivityIndicator(radius: 15))
          : cartResponse == null || cartResponse!.cartData.items.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: cartResponse!.cartData.items.length,
                itemBuilder: (context, index) {
                  final items = cartResponse!.cartData.items[index];
                  return CustomCard(
                    isloadingremove: isRemoving[index],
                    remove: () => removeCartItem(index, items.item_id),
                    image: items.image,
                    title: items.name,
                    disc: 'spicy ${items.spicy}',
                    num: quantities[index],
                    onadd: () => onAdd(index),
                    onmin: () => onMin(index),
                  );
                },
              ),
            ),
      bottomSheet: cartResponse == null || cartResponse!.cartData.items.isEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    blurRadius: 15,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                color: Colors.white,
              ),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Text(
                          "Total ",
                          style: TextStyle(
                            color: Color(0xff3C2F2F),
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              cartResponse!.cartData.TotalPrice,
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    Title: "   Checkout   ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => CheckOutView(
                            totalprice: cartResponse!.cartData.TotalPrice,
                          ),
                        ),
                      );
                    },
                    width: 150,
                  ),
                ],
              ),
            ),
    );
  }
}
