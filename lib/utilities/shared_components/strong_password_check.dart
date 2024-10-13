import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class StrongPasswordCheck extends StatelessWidget {
  final String title;
  final bool isValid;
  const StrongPasswordCheck({super.key, required this.title, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: isValid ? const Color(AppColors.primaryColor): Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isValid ? Icons.check : Icons.close,
              size: 9,
              color: isValid ? Colors.white : Colors.black.withOpacity(0.2),
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: isValid ? Colors.black : Colors.grey[300],
          ),
        )
      ],
    );
  }
}
