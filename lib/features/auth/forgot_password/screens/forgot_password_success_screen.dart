import 'package:flutter/material.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../../../utilities/shared_components/custom_button.dart';
import '../../sing_in/screens/sign_in_screen.dart';

class ForgotPasswordSuccessScreen extends StatelessWidget {
  const ForgotPasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    color: Color(AppColors.primaryColor), shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "Password Reset Successfully",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            const Text(
              "You have successfully reset your password and can now be used to log back into your sStore account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey
              ),
            ),
            const Spacer(),
            CustomButton(
                title: "Finish",
                onClick: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                          (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
