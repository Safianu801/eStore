import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class QuickActionsButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onClick;
  const QuickActionsButton({super.key, required this.title, required this.iconData, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(AppColors.primaryColor).withOpacity(0.05),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(iconData, size: 20,),
                    const SizedBox(width: 10,),
                    Text(title)
                  ],
                ),
                const Icon(Icons.chevron_right_outlined, color: Colors.grey,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
