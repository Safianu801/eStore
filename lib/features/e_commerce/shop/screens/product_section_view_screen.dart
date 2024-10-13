import 'package:e_store/features/e_commerce/shop/components/product_card_style.dart';
import 'package:e_store/features/e_commerce/shop/screens/search_product_screen.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductSectionViewScreen extends StatefulWidget {
  final String title;
  const ProductSectionViewScreen({super.key, required this.title});

  @override
  State<ProductSectionViewScreen> createState() => _ProductSectionViewScreenState();
}

class _ProductSectionViewScreenState extends State<ProductSectionViewScreen> {
  late Future<List<ProductModel>> _futureProducts;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    _futureProducts = productService.getAllProducts(context);
  }

  void _refreshProducts(BuildContext context) {
    setState(() {
      _futureProducts = productService.getAllProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        automaticallyImplyLeading: false,
        leadingWidth: 90,
        leading: CustomBackButton(buildContext: context),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchProductScreen()));
            },
            icon: const Icon(IconlyLight.search, color: Colors.grey)
          )
        ]
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _futureProducts,
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    for (var product in products)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 15,
                        child: ProductCardStyle(productModel: product),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
