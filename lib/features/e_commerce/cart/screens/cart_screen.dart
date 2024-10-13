import 'package:e_store/features/e_commerce/cart/model/cart_model.dart';
import 'package:e_store/utilities/constant/app_colors.dart';
import 'package:e_store/utilities/shared_components/custom_back_button.dart';
import 'package:e_store/utilities/shared_components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/cart_item_card_style.dart';
import '../service/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartModel>> _cartItemsFuture;
  CartServices cartServices = CartServices();
  double _totalPrice = 0.0;
  bool isExpanded = false;

  void _calculateTotalPrice(List<CartModel> cartItems) {
    double total = 0.0;
    for (var cartItem in cartItems) {
      total += cartItem.product.price;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }

  Future<void> _refreshCart() async {
    try {
      setState(() {
        _cartItemsFuture =
            cartServices.getAllCartItems(context).then((cartItems) {
              _calculateTotalPrice(cartItems);
              return cartItems;
            });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteCartItem(String cartItemId) async {
    try {
      await cartServices.removeFromCart(context: context, cartId: cartItemId);
      _refreshCart();
    } catch (err) {
      print(err);
    }
  }

  void _updateTotalPrice(int priceChange) {
    setState(() {
      _totalPrice += priceChange;
    });
  }

  void _checkout() {
    // Implement checkout logic here
    print('Proceed to checkout with total price: $_totalPrice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.whiteColor),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.whiteColor),
        surfaceTintColor: const Color(AppColors.whiteColor),
        leading: CustomBackButton(buildContext: context),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 90,
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCart,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: FutureBuilder<List<CartModel>>(
                future: _cartItemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_empty, color: Colors.grey),
                          Text("Empty Cart!"),
                          Text(
                            "You currently do not have any item in your cart",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 11),
                          )
                        ],
                      ),
                    );
                  } else {
                    final cartItems = snapshot.data!;
                    return ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return CartItemCardStyle(
                          cartItem: cartItem,
                          onRemoveClicked: () {
                            _deleteCartItem(cartItem.itemID);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // Total Price and Checkout Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₦${_formatPrice(_totalPrice)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(title: "Checkout", onClick: () => _totalPrice > 0 ? _checkout : null),
                ],
              ),
            ),
          ],
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
