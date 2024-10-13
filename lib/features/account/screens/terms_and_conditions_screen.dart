import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        leading: CustomBackButton(buildContext: context),
        automaticallyImplyLeading: false,
        title: const Text("Terms & Condition", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Text(AppStrings.termsAndCondition),
      ),
    );
  }
}
