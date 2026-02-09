import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Shared/Custom_button.dart';
import 'package:foodapp/features/checkout/Widgets/Order_detail_widget.dart';
import 'package:gap/gap.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key, required this.totalprice});
  final String totalprice;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  String selectedmethod = "cash";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("assets/icons/arrow-left.png"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order summary", style: TextStyle(fontSize: 20)),
              OrderDetailWidget(
                order: "\$ ${widget.totalprice}",
                takes: "\$3.6",
                fees: "\$10.5",
                total: ((double.tryParse(widget.totalprice) ?? 0) + 3.6 + 10.5)
                    .toStringAsFixed(2),
              ),

              Gap(30),
              Text(
                "Payment methods",
                style: TextStyle(
                  color: Color(0xff3C2F2F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Gap(20),
              ListTile(
                onTap: () => setState(() {
                  selectedmethod = "cash";
                }),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Image.asset("assets/icons/cash.png", width: 50),
                tileColor: Color(0xff3C2F2F),
                title: Text(
                  "Cash on Delivery",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "cash",
                  groupValue: selectedmethod,
                  focusColor: Colors.white,
                  onChanged: (c) => setState(() {
                    selectedmethod = c!;
                  }),
                ),
              ),
              Gap(10),
              ListTile(
                onTap: () => setState(() {
                  selectedmethod = "visa";
                }),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Image.asset(
                  "assets/icons/visa.png",
                  width: 50,
                  color: Colors.white,
                ),
                tileColor: Colors.blue.shade900,
                title: Text(
                  "Debit card",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                subtitle: Text(
                  "**** **** 4165",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "visa",
                  groupValue: selectedmethod,
                  focusColor: Colors.white,
                  onChanged: (c) => setState(() {
                    selectedmethod = c!;
                  }),
                ),
              ),
              Gap(15),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.red,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "Save card details for future payments",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Gap(300),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(color: AppColor.primary, fontSize: 32),
                      ),
                      Text(
                        ((double.tryParse(widget.totalprice) ?? 0) + 3.6 + 10.5)
                            .toStringAsFixed(2),
                        style: TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            CustomButton(
              Title: "Pay Now",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 180),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColor.primary,
                                  child: Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.white,
                                    size: 38,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Success !",
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Your payment was successful.\n A receipt for this purchase has\n been sent to your email.",
                                    style: TextStyle(color: Color(0xffBCBBBB)),
                                  ),
                                ),
                                Spacer(),
                                CustomButton(
                                  Title: "Back",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
