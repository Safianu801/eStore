import 'package:e_store/features/e_commerce/shop/components/product_card_style.dart';
import 'package:e_store/features/e_commerce/shop/screens/product_section_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../../../../utilities/constant/app_colors.dart';

class ProductSection extends StatefulWidget {
  final String title;
  final Future<List<ProductModel>> futureProducts;
  final List<String> categories;

  const ProductSection({
    super.key,
    required this.title,
    required this.futureProducts,
    required this.categories,
  });

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
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
        } else {
          List<ProductModel> products = snapshot.data ?? [];
          List<Widget> categorySections = widget.categories.map((category) {
            List<ProductModel> categoryProducts = products
                .where((product) => product.category == category)
                .toList();
            if (categoryProducts.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductSectionViewScreen(title: category),
                          ));
                        },
                        child: const Text(
                          "see more",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(AppColors.primaryColor),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                    itemCount: categoryProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      ProductModel product = categoryProducts[index];
                      return ProductCardStyle(productModel: product);
                    },
                  ),
                ),
              ],
            );
          }).toList();
          categorySections.removeWhere((section) => section is SizedBox);
          return Column(
            children: categorySections,
          );
        }
      },
    );
  }
}
