import 'package:e_store/features/auth/sign_up/screens/password_screen.dart';
import 'package:e_store/utilities/shared_components/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../../../utilities/shared_components/custom_Text_field_one.dart';
import '../../../../utilities/shared_components/custom_back_button.dart';
import '../../../../utilities/shared_components/custom_button.dart';

class EmailScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  const EmailScreen({super.key, required this.firstName, required this.lastName});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
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
              "Valid Email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ),
            const Text(
              "Please make sure to provide us a valid email address for easy account verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10,),
            CustomTextFieldOne(hintText: "Enter Email", controller: emailController, iconData: IconlyLight.message, isObscure: false),
            const SizedBox(height: 10,),
            CustomTextFieldOne(hintText: "Confirm Email", controller: confirmEmailController, iconData: IconlyLight.message, isObscure: false),
            const Spacer(),
            CustomButton(title: "Next", onClick: (){
              if (emailController.text.trim() == confirmEmailController.text.trim() && emailController.text.trim().isNotEmpty && confirmEmailController.text.trim().isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PasswordScreen(firstName: widget.firstName, lastName: widget.lastName, email: emailController.text.trim())));
              } else {
                showSnackBar(context: context, message: "Please make sure you provide a matching email to be able to proceed to the next stage", title: "Matching Email Required");
              }
            })
          ],
        ),
      ),
    );
  }
}
