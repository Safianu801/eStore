import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class PopularProductsSection extends StatefulWidget {
  final Future<List<ProductModel>> futureProducts;
  const PopularProductsSection({super.key, required this.futureProducts});

  @override
  State<PopularProductsSection> createState() => _PopularProductsSectionState();
}

class _PopularProductsSectionState extends State<PopularProductsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<ProductModel>>(
            future: widget.futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (snapshot.hasError) {
                return const SizedBox.shrink();
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              }else {
                List<ProductModel> products = snapshot.data ?? [];
                return SizedBox(
                  height: 174,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Most Popular",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: products.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            ProductModel product = products[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Container(
                                height: 180,
                                width: 140,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Image.network(product.image),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
