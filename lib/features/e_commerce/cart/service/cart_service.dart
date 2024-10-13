import 'dart:convert';
import 'package:e_store/features/e_commerce/cart/model/cart_model.dart';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utilities/shared_components/httpErrorHandler.dart';
import '../../../../utilities/shared_components/show_snack_bar.dart';
import '../../../auth/model/user_model.dart';
import '../../../auth/model/user_provider.dart';

class CartServices {
  String baseUrl = AppStrings.liveUrl;

  Future<void> addToCart({
    required BuildContext context,
    required int product,
    required int totalQuantity,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("Authorization");

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/e-stores/carts/add'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': product,
          "totalQuantity": totalQuantity,
        }),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(context: context, message: "This item has been successfully added to your cart and is now ready for checkout", title: "Item Added To Cart Successfully");
        httpErrorHandler(
            response: response,
            context: context,
            onSuccess: () {
              UserModel user = userProvider.userModel.copyWith(
                cart: jsonDecode(response.body)['cart'],
              );
              userProvider.setUserFromModel(user);
            });
      } else {
        showSnackBar(context: context, message: "Unable to add item to cart", title: "Field To Add To Cart");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required String cartId,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("Authorization");
      final response = await http.delete(
        Uri.parse('$baseUrl/api/v1/e-stores/carts/remove-from-cart'),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'cartId': cartId,
        }),
      );
      httpErrorHandler(response: response, context: context, onSuccess: () {});
    } catch (error) {
      throw Exception('Failed to delete cart item: $error');
    }
  }

  Future<List<CartModel>> getAllCartItems(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');
    List<CartModel> cartItems = [];

    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/v1/e-stores/carts/cart-items'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        final responseData = jsonDecode(res.body);
        if (responseData['cart'] != null && responseData['cart'] is List) {
          final List<dynamic> cartList = responseData['cart'];
          for (var cartData in cartList) {
            cartItems.add(CartModel.fromMap(cartData));
          }
        } else {}
      } else if (res.statusCode == 404) {
      } else {
        throw Exception('Failed to fetch cart. Status code: ${res.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return cartItems;
  }
}
