import 'package:e_store/features/auth/sign_up/screens/email_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_Text_field_one.dart';
import 'package:e_store/utilities/shared_components/custom_button.dart';
import 'package:e_store/utilities/shared_components/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/shared_components/custom_back_button.dart';

class NamesScreen extends StatefulWidget {
  const NamesScreen({super.key});

  @override
  State<NamesScreen> createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
              "Legal Names",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
            const Text(
              "Please make sure to provide your name correctly",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10,),
            CustomTextFieldOne(hintText: "First Name", controller: firstNameController, iconData: IconlyLight.profile, isObscure: false),
            const SizedBox(height: 10,),
            CustomTextFieldOne(hintText: "Last Name", controller: lastNameController, iconData: IconlyLight.profile, isObscure: false),
            const Spacer(),
            CustomButton(title: "Next", onClick: (){
              if (firstNameController.text.trim().isNotEmpty && lastNameController.text.trim().isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailScreen(firstName: firstNameController.text.trim(), lastName: lastNameController.text.trim())));
              } else {
                showSnackBar(context: context, message: "Please make sure you provide your first and last name", title: "First Name And Last Name Required");
              }
            })
          ],
        ),
      ),
    );
  }
}
