import 'package:flutter/material.dart';

class AdvertSection extends StatefulWidget {
  const AdvertSection({super.key});

  @override
  State<AdvertSection> createState() => _AdvertSectionState();
}

class _AdvertSectionState extends State<AdvertSection> {
  final bannerImages = [
    "images/banner_four.jfif",
    // "images/banner_one.jfif",
    "images/banner_three.jfif",
    "images/banner_two.jfif",
  ];
  final bannerTitle = [
    "Shop With Ease",
    // "images/banner_one.jfif",
    "Place Your Order And Relax",
    "Place An Order For Someone",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: bannerImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width / 1.3,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image.asset(bannerImages[index], fit: BoxFit.cover,),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        bannerTitle[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
