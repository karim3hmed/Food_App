import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Auth/data/auth_repo.dart';
import 'package:foodapp/features/Auth/views/signup_view.dart';
import 'package:foodapp/features/Auth/widget/Custom_textfield.dart';
import 'package:foodapp/features/Auth/widget/custom_button.dart';
import 'package:foodapp/features/Shared/custom_snak.dart';
import 'package:foodapp/root.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AuthRepo authRepo = AuthRepo();

  bool isLoading = false; // ⭐ loading state

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepo.login(
        emailController.text.trim(),
        passController.text.trim(),
      );

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Root()),
        );
      }
    } catch (e) {
      final message = e is ApiError ? e.message : e.toString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnak(message, const Color.fromARGB(255, 124, 5, 5)));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Gap(90),
                      SvgPicture.asset(
                        "assets/logo/logo.svg",
                        color: AppColor.primary,
                      ),
                      Gap(10),
                      Text(
                        "Welcom Back , Discover The Fast Food",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 100,
                      left: 20,
                      right: 20,
                      top: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55),
                      ),
                    ),
                    child: Column(
                      children: [
                        Gap(50),
                        CustomTextfield(
                          hint: "Email Address ",
                          controller: emailController,
                          ispassword: false,
                        ),
                        Gap(20),
                        CustomTextfield(
                          hint: "Password ",
                          controller: passController,
                          ispassword: true,
                        ),
                        Gap(30),

                        /// LOGIN BUTTON WITH LOADING
                        ///
                        isLoading
                            ? CupertinoActivityIndicator(
                                color: Colors.white,
                                radius: 16,
                              )
                            : CustomButtonAuth(
                                color: Colors.transparent,
                                textcolor: Colors.white,
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                title: "Login",
                              ),

                        Gap(15),
                        CustomButtonAuth(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (c) => SignupView()),
                            );
                          },
                          title: "Create Acount ?",
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (c) => Root()),
                            );
                          },
                          child: Text(
                            "Continue as a Guest?",
                            style: TextStyle(
                              color: Colors.orange.shade300,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
