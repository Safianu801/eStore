import 'dart:async';

import 'package:e_store/features/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:e_store/features/auth/service/auth_service.dart';
import 'package:e_store/features/auth/sign_up/screens/names_screen.dart';
import 'package:e_store/utilities/constant/app_icons.dart';
import 'package:e_store/utilities/shared_components/custom_Text_field_one.dart';
import 'package:e_store/utilities/shared_components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/constant/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthService authService = AuthService();
  bool isLoading = false;
  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      await authService.userLogin(context, email, password);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 100,
                width: 100,
                child: Image.asset(AppIcons.appLogo, color: const Color(AppColors.primaryColor),)),
            const SizedBox(height: 15,),
            CustomTextFieldOne(hintText: "Enter Email", controller: emailController, iconData: IconlyLight.message, isObscure: false,),
            const SizedBox(height: 10,),
            CustomTextFieldOne(hintText: "Enter Password", controller: passwordController, iconData: IconlyLight.lock, isObscure: isChecked ? false : true, suffixIcon: IconButton(onPressed: (){
              setState(() {
                isChecked = !isChecked;
              });
            }, icon: Icon(isChecked ? Icons.remove_red_eye : Icons.remove_red_eye_outlined, size: 22,)),),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
            isLoading ? const CupertinoActivityIndicator() : CustomButton(title: "Sign In", onClick: (){
              if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
                loginUser(context, emailController.text.trim(), passwordController.text.trim());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please provide all data")));
              }
            }),
            const Spacer(),
            Row(
              children: [
                Expanded(child: Container(height: 1, width: MediaQuery.of(context).size.width, decoration: const BoxDecoration(color: Color(AppColors.primaryColor)),)),
                const Text(
                  " or ",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                Expanded(child: Container(height: 1, width: MediaQuery.of(context).size.width, decoration: const BoxDecoration(color: Color(AppColors.primaryColor)),)),
              ],
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NamesScreen()));
              },
              child: RichText(text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    )
                  ),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: Color(AppColors.primaryColor),
                          fontSize: 14
                      )
                  ),
                ]
              )),
            )
          ],
        ),
      ),
    );
  }
}
