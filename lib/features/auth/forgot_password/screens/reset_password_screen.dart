import 'package:e_store/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../../../utilities/shared_components/custom_Text_field_one.dart';
import '../../../../utilities/shared_components/custom_button.dart';
import '../../../../utilities/shared_components/strong_password_check.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isEyeClicked = false;
  bool isLoading = false;

  AuthService authService = AuthService();

  bool isPasswordValid() {
    bool hasMinLength = passwordController.text.length >= 6;
    bool hasDigits = RegExp(r'\d').hasMatch(passwordController.text);
    bool hasUpperCase = RegExp(r'[A-Z]').hasMatch(passwordController.text);
    bool hasLowerCase = RegExp(r'[a-z]').hasMatch(passwordController.text);
    bool hasSymbols =
    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(passwordController.text);

    return hasMinLength &&
        hasDigits &&
        hasUpperCase &&
        hasLowerCase &&
        hasSymbols;
  }

  Future<void> resetUserPassword(BuildContext context, String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      await authService.resetPassword(context, email, password,);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(AppColors.whiteColor),
            appBar: AppBar(
              backgroundColor: const Color(AppColors.whiteColor),
              surfaceTintColor: const Color(AppColors.whiteColor),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Text(
                    "Create New Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const Text(
                    "Create a new password that is powerful and hopefully won't be easily forgotten again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFieldOne(
                    isObscure: isEyeClicked ? false : true,
                    controller: passwordController,
                    onChange: (value) {
                      setState(() {});
                    },
                    hintText: "Enter password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isEyeClicked = !isEyeClicked;
                          });
                        },
                        icon: Icon(
                          isEyeClicked
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 22,
                        )), iconData: IconlyLight.lock,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StrongPasswordCheck(
                    title: "6 characters and above",
                    isValid: passwordController.text.length >= 6,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StrongPasswordCheck(
                    title: "use of number",
                    isValid: RegExp(r'\d').hasMatch(passwordController.text),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StrongPasswordCheck(
                    title: "use of capital letter",
                    isValid: RegExp(r'[A-Z]').hasMatch(passwordController.text),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StrongPasswordCheck(
                    title: "use of small letter",
                    isValid: RegExp(r'[a-z]').hasMatch(passwordController.text),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StrongPasswordCheck(
                    title: "use of symbol",
                    isValid: RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                        .hasMatch(passwordController.text),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldOne(
                    isObscure: isEyeClicked ? false : true,
                    controller: confirmPasswordController,
                    onChange: (value) {
                      setState(() {});
                    },
                    hintText: "Confirm password",
                    iconData: IconlyLight.lock,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isEyeClicked = !isEyeClicked;
                          });
                        },
                        icon: Icon(
                          isEyeClicked
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 22,
                        )),
                  ),
                  const Spacer(),
                  isLoading ? const CupertinoActivityIndicator() : CustomButton(
                      title: "Reset Password",
                      onClick: () {
                        if (passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty &&
                            passwordController.text == confirmPasswordController.text &&
                            isPasswordValid()) {
                          resetUserPassword(context, widget.email, passwordController.text.trim());
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please make sure to provide a password that matches")));
                        }
                      })
                ],
              ),
            ),
          ),
          if (isLoading) Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.01)
          ),)
        ],
      ),
    );
  }
}
