import 'package:e_store/features/e_commerce/shop/components/other_information_card.dart';
import 'package:e_store/features/e_commerce/shop/components/product_size.dart';
import 'package:e_store/features/e_commerce/shop/components/quantity_section.dart';
import 'package:e_store/features/e_commerce/shop/model/product_model.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:e_store/utilities/shared_components/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/shared_components/show_snack_bar.dart';
import '../../cart/service/cart_service.dart';

class ProductViewScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductViewScreen({super.key, required this.productModel});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  double _totalPrice = 0.0;
  int productQuantity = 0;
  bool isLoading = false;
  void _updateTotalPrice(double priceChange) {
    setState(() {
      _totalPrice += priceChange;
      productQuantity += 1;
    });
  }
  CartServices cartServices = CartServices();
  Future<void> _addItemToCart(BuildContext context) async {
    try {
      if (_totalPrice != 0) {
        setState(() {
          isLoading = true;
        });
        await cartServices.addToCart(
          context: context,
          product: widget.productModel.id,
          totalQuantity: productQuantity,
        );
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context: context,
          message: "Please tell us how many you want",
          title: "Quantity",
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
  final colors = [
    Colors.red,
    Colors.orange,
    Colors.cyan
  ];
  final names = [
    "Red",
    "Orange",
    "Cyan"
  ];
  String selectedColor = "Orange";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(AppColors.whiteColor),
            appBar: AppBar(
              backgroundColor: const Color(AppColors.whiteColor),
              surfaceTintColor: const Color(AppColors.whiteColor),
              automaticallyImplyLeading: false,
              leadingWidth: 90,
              leading: CustomBackButton(buildContext: context),
              title: const Text(
                "Details",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Text(
                        "${AppStrings.nairaSign}${_formatPrice(widget.productModel.price)}",
                        style: const TextStyle(
                            fontSize: 14
                        ),
                      ),
                      const Text(
                        "Item price",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                          ),
                          child: Image.network(widget.productModel.image),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(child: Text(widget.productModel.title, style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),)),
                            Row(
                              children: [
                                for (int i = 0; i < colors.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selectedColor = names[i];
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: selectedColor == names[i] ? colors[i] : Colors.transparent),
                                            shape: BoxShape.circle
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: colors[i],
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.green),
                                      shape: BoxShape.circle
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check, size: 8, color: Colors.green,),
                                  ),
                                ),
                                const Text(
                                  " Available in stock",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 20,),
                            const Row(
                              children: [
                                Icon(Icons.star, size: 15, color: Colors.orange,),
                                Text(
                                  " 4.6",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "(273 Reviews)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 15,),
                        const ProductSize(),
                        const SizedBox(height: 10,),
                        QuantitySection(
                          totalPrice: widget.productModel.price,
                          onQuantityChanged: (priceChange) =>
                              _updateTotalPrice(priceChange),
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        ReadMoreText(longText: widget.productModel.description),
                        const Text(
                            "#real #cloths #female #male #flex",
                            style: TextStyle(
                                color: Color(AppColors.primaryColor)
                            )
                        ),
                        const SizedBox(height: 10,),
                        const OtherInformationCard(icon: IconlyLight.calendar, title: "Shipping Information"),
                        const OtherInformationCard(icon: Icons.keyboard_return_outlined, title: "Returns"),
                        const OtherInformationCard(icon: IconlyLight.message, title: "Reviews"),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text(
                              "Product Category: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.5),
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text(
                              " ${widget.productModel.category}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Text(
                              "SUK: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),
                            ),
                            Text(
                              "#23456789",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: GestureDetector(
              onTap: () => _addItemToCart(context),
              child: Container(
                height: 90,
                width: 70,
                decoration: BoxDecoration(
                    color: const Color(AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(IconlyLight.bag, color: Colors.white,),
                      Text(
                        "${AppStrings.nairaSign}${_formatPrice(_totalPrice)}",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2)
              ),
              child: const Center(
                child: Text(
                  "Please wait..",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
  String _formatPrice(double price) {
    try {
      return _formatNumber(price);
    } catch (e) {
      return '0';
    }
  }

  String _formatNumber(double number) {
    NumberFormat formatter = NumberFormat("#,###");
    return formatter.format(number);
  }
}
