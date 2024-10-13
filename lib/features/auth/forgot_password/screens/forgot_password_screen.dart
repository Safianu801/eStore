import 'package:e_store/features/auth/forgot_password/screens/reset_password_screen.dart';
import 'package:e_store/utilities/shared_components/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../../../utilities/shared_components/custom_Text_field_one.dart';
import '../../../../utilities/shared_components/custom_back_button.dart';
import '../../../../utilities/shared_components/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        automaticallyImplyLeading: false,
        leadingWidth: 90,
        leading: CustomBackButton(buildContext: context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const Text(
              "Forgot You Password?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Don't worry we've got you covered, please provide your email registered to your e-store account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFieldOne(
                hintText: "Enter Email",
                controller: emailController,
                iconData: IconlyLight.message,
                isObscure: false),
            const Spacer(),
            CustomButton(
                title: "Next",
                onClick: () {
                  if (emailController.text.trim().isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen(email: emailController.text.trim(),)));
                  } else {
                    showSnackBar(
                        context: context,
                        message:
                            "Please make sure you provide your email before attempting to proceed to the next stage",
                        title: "Email Required");
                  }
                })
          ],
        ),
      ),
    );
  }
}
