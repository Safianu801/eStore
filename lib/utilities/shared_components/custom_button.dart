import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final Color? color;
  const CustomButton({super.key, required this.title, required this.onClick, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color ?? const Color(AppColors.primaryColor),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12
            ),
          ),
        ),
      ),
    );
  }
}
