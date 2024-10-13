import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final images = [
    "images/home_two.jfif",
    "images/kids.jfif",
    "images/male.jfif",
    "images/females.jfif",
  ];
  final cats = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing",
  ];
  String selectedCat = "All";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < cats.length; i++)
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedCat = cats[i];
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: selectedCat == cats[i] ? const Color(AppColors.primaryColor) : Colors.transparent)
                        ),
                        child: Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(images[i], fit: BoxFit.cover,),
                        ),
                      ),
                      Center(
                        child: Text(cats[i], style: TextStyle(
                            color: selectedCat == cats[i] ? const Color(AppColors.primaryColor) : Colors.black,
                            fontSize: 11
                        ),),
                      )
                    ],
                  ),
                )
            ],
          ),
        ],
      )
    );
  }
}

