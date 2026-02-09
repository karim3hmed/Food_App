import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Auth/data/auth_repo.dart';
import 'package:foodapp/features/Auth/data/user_model.dart';
import 'package:foodapp/features/Auth/views/login_view.dart';
import 'package:foodapp/features/Auth/widget/custom_user_txt_field.dart';
import 'package:foodapp/features/Home/Views/Home_view.dart';
import 'package:foodapp/features/Shared/custom_snak.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // ignore: non_constant_identifier_names
  TextEditingController Name = TextEditingController();
  TextEditingController Visa = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController address = TextEditingController();
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  Future<void> logout() async {
    await authRepo.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (c) {
          return LoginView();
        },
      ),
    );
  }

  Future<void> updatedata() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepo.updatedata(
        Name.text.trim(),
        email.text.trim(),
        address.text.trim(),
      );
      setState(() {
        userModel = user;
      });

      setState(() {
        userModel = user;
      });
      await getprofiledata();
    } on ApiError catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnak(e.message, Colors.red));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnak("Unexpected error", Colors.red));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> getprofiledata() async {
    try {
      final user = await authRepo.getprofiledata();
      setState(() {
        userModel = user;
        Name.text = userModel?.name ?? "";
        email.text = userModel?.email ?? "";
        address.text = userModel?.address ?? "55Dubai UAE";
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnak("Update Data success", Color(0xFF4CAF50)));
    } catch (e) {
      String errormsg = "error in profile view";

      if (e is ApiError) {
        errormsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        customSnak(errormsg, const Color.fromARGB(255, 124, 5, 5)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getprofiledata();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getprofiledata();
      },
      backgroundColor: Colors.black,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColor.primary,
          appBar: AppBar(
            actionsPadding: EdgeInsets.only(right: 10),
            backgroundColor: AppColor.primary,
            elevation: 0,
            toolbarHeight: 0,
            scrolledUnderElevation: 0,
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (C) {
                                  return HomeView();
                                },
                              ),
                            );
                          },
                          child: Image.asset(
                            "assets/icons/arrow-left.png",
                            color: Colors.white,
                          ),
                        ),
                        SvgPicture.asset("assets/icons/settings.svg"),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 130,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://tse4.mm.bing.net/th/id/OIP.hGSCbXlcOjL_9mmzerqAbQHaHa?pid=Api&P=0&h=220",
                            ),
                          ),

                          border: Border.all(width: 2, color: Colors.black),
                        ),
                      ),
                    ),
                    Gap(20),
                    CustomUserTxtField(controller: Name, label: "Name"),
                    Gap(25),
                    CustomUserTxtField(controller: email, label: "Email"),
                    Gap(25),
                    CustomUserTxtField(controller: address, label: "Address"),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Divider(
                        color: Color.fromARGB(255, 241, 237, 237),
                        thickness: 0.9,
                        height: 50,
                      ),
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      leading: Image.asset("assets/icons/visa.png", width: 50),
                      tileColor: Colors.white,
                      title: Text(
                        "Debit card",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      subtitle: Text(
                        userModel?.visa ?? "**** **** 4165",
                        style: TextStyle(color: Colors.black, fontSize: 19),
                      ),
                      trailing: Text(
                        "Default",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),

                    Gap(200),
                  ],
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: updatedata,
                  child: isLoading
                      ? CupertinoActivityIndicator(
                          color: Colors.black,
                          radius: 16,
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Gap(7),
                              Icon(Icons.edit, size: 20),
                            ],
                          ),
                        ),
                ),

                GestureDetector(
                  onTap: logout,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.primary, width: 2.5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Log out",
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 20,
                          ),
                        ),
                        Gap(7),
                        Icon(Icons.logout, size: 20, color: AppColor.primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
