import 'package:e_store/features/e_commerce/shop/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/constant/app_colors.dart';
import '../../../../utilities/constant/app_strings.dart';
import '../screens/product_view_screen.dart';

class ProductCardStyle extends StatelessWidget {
  final ProductModel productModel;
  const ProductCardStyle({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductViewScreen(productModel: productModel),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 3) - 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    productModel.image,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                productModel.title.length > 8
                    ? "${productModel.title.substring(0, 8)}..."
                    : productModel.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                productModel.category,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                "${AppStrings.nairaSign}${productModel.price}",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(AppColors.primaryColor).withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
