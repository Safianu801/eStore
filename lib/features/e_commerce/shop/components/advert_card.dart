import 'package:flutter/material.dart';

class AdvertCard extends StatelessWidget {
  const AdvertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Image.asset("images/bad_advert_one.jfif", fit: BoxFit.cover,),
            ),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "From the edit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    ),
                  ),
                  const Text(
                    "Here's where to get summer's best \nhand bags",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text(
                        "Shop Now",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
