import 'package:e_store/features/e_commerce/cart/model/cart_model.dart';
import 'package:e_store/utilities/shared_components/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItemCardStyle extends StatefulWidget {
  final CartModel cartItem;
  final VoidCallback onRemoveClicked;

  const CartItemCardStyle(
      {super.key, required this.onRemoveClicked, required this.cartItem});

  @override
  State<CartItemCardStyle> createState() => _CartItemCardStyleState();
}

class _CartItemCardStyleState extends State<CartItemCardStyle> {
  int initialQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final currentValue = initialQuantity = widget.cartItem.totalQuantity;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 82,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(widget.cartItem.product.image),
                  )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 6,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartItem.product.title.length > 25
                              ? "${widget.cartItem.product.title.substring(0, 25)}..."
                              : widget.cartItem.product.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.cartItem.product.description.length > 20
                              ? "${widget.cartItem.product.description.substring(0, 20)}..."
                              : widget.cartItem.product.description,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: "₦",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: _formatPrice(widget.cartItem.product.price),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,)),
                                ])),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSnackBar(context: context, message: "You can't decrease the product quantity", title: "Decrease Field");
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(" $currentValue "),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSnackBar(context: context, message: "You can't increase the product quantity", title: "Increase Field");
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        shape: BoxShape.circle),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              const Spacer(),
              SizedBox(
                child: IconButton(
                  onPressed: widget.onRemoveClicked,
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
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
