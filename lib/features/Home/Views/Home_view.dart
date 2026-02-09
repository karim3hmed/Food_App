// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/features/Home/Data/product_model.dart';
import 'package:foodapp/features/Home/Data/product_repo.dart';
import 'package:foodapp/features/Home/widget/card_item.dart';
import 'package:foodapp/features/product/Views/product_detail_view.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widget/Food_categories.dart';
import '../widget/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = ["All", "Combos", "Sliders", "Classic"];
  int selectedindex = 0;

  final ProductRepo productRepo = ProductRepo();
  List<ProductModel>? products;

  Future<void> getProduct() async {
    final product = await productRepo.getProduct();
    setState(() {
      products = product;
    });
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 90,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
                  child: UserHeader(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: const [
                      SearchBar(
                        hintText: "search..",
                        leading: Icon(CupertinoIcons.search),
                      ),
                      Gap(20),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Foodgategories(
                    categories: ["All", "Combos", "Sliders", "Classic"],
                    selectedindex: 0,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Gap(20)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (products == null) {
                      return Card(color: Colors.grey.shade300);
                    }

                    final product = products![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailView(
                              productid: product.id,
                              productprice: product.price,
                            ),
                          ),
                        );
                      },
                      child: CardItem(
                        image: product.image.replaceFirst(
                          'http://',
                          'https://',
                        ),
                        title: product.name,
                        desc: product.desc,
                        rate: product.rate,
                      ),
                    );
                  }, childCount: products == null ? 6 : products!.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.01,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
