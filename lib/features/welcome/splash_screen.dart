import 'dart:async';
import 'package:e_store/features/auth/sing_in/screens/sign_in_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/constant/app_icons.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          height: 120,
            width: 120,
            child: Image.asset(AppIcons.appLogo, color: const Color(AppColors.primaryColor),)),
      ),
    );
  }
}
