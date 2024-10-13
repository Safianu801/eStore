import 'package:e_store/utilities/constant/app_icons.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext buildContext;
  const CustomBackButton({super.key, required this.buildContext});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(buildContext);
      },
      child: Container(
        width: 40,
        decoration: const BoxDecoration(
          color: Colors.transparent
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                    width: 30,
                    child: Image.asset(AppIcons.backIcon, color: Colors.grey,)),
                const Text(
                  "go back",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
