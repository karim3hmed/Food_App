import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/constants/app_color.dart';
import 'package:foodapp/features/Auth/data/auth_repo.dart';
import 'package:foodapp/features/Auth/views/login_view.dart';
import 'package:foodapp/features/Auth/widget/Custom_textfield.dart';
import 'package:foodapp/features/Auth/widget/custom_button.dart';
import 'package:foodapp/features/Shared/custom_snak.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  Future<void> signup() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = await authRepo.signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passController.text.trim(),
        );
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnak(
              "Account created! Login to continue...",
              Color(0xFF4CAF50),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) {
                return LoginView();
              },
            ),
          );
        }
      } catch (e) {
        String msgerror = "unkown error";
        if (e is ApiError) {
          msgerror = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          customSnak(msgerror, const Color.fromARGB(255, 124, 5, 5)),
        );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
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
            // ignore: avoid_unnecessary_containers
            child: Column(
              children: [
                Gap(150),
                SvgPicture.asset(
                  "assets/logo/logo.svg",
                  // ignore: deprecated_member_use
                  color: AppColor.primary,
                ),
                Gap(10),
                Text(
                  "Welcom To Our Food App",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Gap(70),

                // ignore: avoid_unnecessary_containers
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        children: [
                          CustomTextfield(
                            hint: "Name",
                            controller: nameController,
                            ispassword: false,
                          ),
                          Gap(18),
                          CustomTextfield(
                            hint: "Email Address ",
                            controller: emailController,
                            ispassword: false,
                          ),
                          Gap(18),

                          CustomTextfield(
                            hint: "Password ",
                            controller: passController,
                            ispassword: true,
                          ),
                          Gap(40),

                          isLoading
                              ? CupertinoActivityIndicator(
                                  color: Colors.white,
                                  radius: 16,
                                )
                              : CustomButtonAuth(
                                  onTap: signup,
                                  title: "Signup",
                                ),

                          Gap(15),
                          CustomButtonAuth(
                            textcolor: Colors.white,
                            color: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: "Go to login",
                          ),
                        ],
                      ),
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
