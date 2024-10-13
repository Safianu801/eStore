import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../cart/screens/cart_screen.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen()));
      },
      child: SizedBox(
        height: 55,
        width: 55,
        child: Stack(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: const Color(AppColors.primaryColor),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(5, 10),
                        blurRadius: 20,
                        spreadRadius: 5
                    )
                  ]
              ),
              child: const Center(
                child: Icon(IconlyLight.bag, color: Colors.white,),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          spreadRadius: 5
                      )
                    ]
                ),
                child: const Center(
                  child: Text(
                    "5",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
