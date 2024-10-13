import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  const ProductSize({super.key});

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  final sizes = [
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ];
  String selectedSize = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Size",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < sizes.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedSize = sizes[i];
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: selectedSize == sizes[i] ? const Color(AppColors.primaryColor) : Colors.transparent)
                      ),
                      child: Center(
                        child: Text(
                          sizes[i],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
