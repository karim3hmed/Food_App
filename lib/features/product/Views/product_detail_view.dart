import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Shared/Custom_button.dart';
import 'package:foodapp/features/Shared/custom_snak.dart';
import 'package:foodapp/features/product/data/cart_Repo.dart';
import 'package:foodapp/features/product/data/cart_model.dart';
import 'package:foodapp/features/product/data/product_deatail_model.dart';
import 'package:foodapp/features/product/widget/side_options_cart.dart';
import 'package:foodapp/features/product/widget/spicy_slider.dart';
import 'package:foodapp/features/product/widget/topping_card.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Home/Data/product_repo.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productid,
    required this.productprice,
  });
  final int productid;
  final String productprice;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  double value = 45;

  List<ProductDeatailModel>? toppings;
  List<ProductDeatailModel>? sideOptions;

  final List<int> selectedToppings = [];
  final List<int> selectedSideOptions = [];
  bool isloadingcart = false;

  final ProductRepo productRepo = ProductRepo();
  final CartRepo cartRepo = CartRepo();

  Future<void> getToppings() async {
    final data = await productRepo.gettopping();
    setState(() => toppings = data);
  }

  Future<void> getSideOptions() async {
    final data = await productRepo.getSideOption();
    setState(() => sideOptions = data);
  }

  @override
  void initState() {
    super.initState();
    getToppings();
    getSideOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: toppings == null || sideOptions == null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/icons/arrow-left.png"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  value: value,
                  onChanged: (v) => setState(() => value = v),
                ),
                const Gap(15),
                const Text(
                  "Toppings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                toppings == null
                    ? const CupertinoActivityIndicator()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: toppings!.map((topping) {
                            final id = topping.id!;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Toppingcard(
                                name: topping.name,
                                image: topping.image.replaceFirst(
                                  'http://',
                                  'https://',
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedToppings.contains(id)
                                        ? selectedToppings.remove(id)
                                        : selectedToppings.add(id);
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                const Gap(20),
                const Text(
                  "Side options",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                sideOptions == null
                    ? const CupertinoActivityIndicator()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sideOptions!.map((option) {
                            final id = option.id!;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: SideOptionsCart(
                                name: option.name,
                                image: option.image.replaceFirst(
                                  'http://',
                                  'https://',
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedSideOptions.contains(id)
                                        ? selectedSideOptions.remove(id)
                                        : selectedSideOptions.add(id);
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              "${widget.productprice}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isloadingcart == true
                        ? CupertinoActivityIndicator(
                            radius: 14,
                            color: Colors.black,
                          )
                        : CustomButton(
                            Title: "Add To Cart",
                            onTap: () async {
                              final cart = CartModel(
                                product_id: widget.productid,
                                quantity: 1,
                                spicy: value / 100,
                                toppings: selectedToppings,
                                options: selectedSideOptions,
                              );

                              try {
                                setState(() {
                                  isloadingcart = true;
                                });
                                await cartRepo.addtocart(
                                  CartRequestModel(items: [cart]),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnak(
                                    "Successs To Add The Cart",
                                    Colors.green,
                                  ),
                                );
                                setState(() {
                                  isloadingcart = false;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnak(e.toString(), Colors.red),
                                );
                                isloadingcart = false;
                              }
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
