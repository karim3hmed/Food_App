import 'package:flutter/material.dart';
import 'package:foodapp/features/checkout/Widgets/Custom_Row_Checkout.dart';
import 'package:gap/gap.dart';

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    super.key,
    required this.order,
    required this.takes,
    required this.fees,
    required this.total,
  });
  final String order, takes, fees, total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CustomRowCheckout(title: "Order", value: order),
          CustomRowCheckout(title: "Taxes", value: takes),
          CustomRowCheckout(title: "Delivery fees", value: fees),
          Gap(10),
          Divider(color: Color(0xffF0F0F0), thickness: 1.5),
          Gap(30),
          CustomRowCheckout(
            title: "Total:",
            value: total,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          Gap(10),
          CustomRowCheckout(
            title: "Estimated delivery time:",
            value: "15 - 30 mins",
            fontWeight: FontWeight.bold,
            color: Color(0xff3C2F2F),
            size: 16,
          ),
        ],
      ),
    );
  }
}
