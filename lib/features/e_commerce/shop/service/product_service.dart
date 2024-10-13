import 'dart:convert';
import 'dart:io';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utilities/shared_components/show_snack_bar.dart';
import '../model/product_model.dart';

class ProductService {

  String baseUrl = AppStrings.liveUrl;
  Future<List<ProductModel>> getAllProducts(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');
    List<ProductModel> productList = [];
    try {
      final res = await http
          .get(Uri.parse('$baseUrl/api/v1/e-stores/products/get-all-product'), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        final List<dynamic> responseData = jsonDecode(res.body)['products'];
        for (var productData in responseData) {
          productList.add(ProductModel.fromMap(productData));
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw e;
    }
    return productList;
  }

  Future<List<ProductModel>> searchProducts({
    required BuildContext context,
    String? name,
    String? description,
    String? category,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');
    List<ProductModel> productList = [];
    try {
      Map<String, String> queryParameters = {};
      if (name != null) queryParameters['name'] = name;
      if (description != null) queryParameters['description'] = description;
      if (category != null) queryParameters['category'] = category;
      final uri = Uri.parse('$baseUrl/api/v1/e-stores/products/search')
          .replace(queryParameters: queryParameters);

      final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final List<dynamic> responseData = jsonDecode(res.body)['products'];
        for (var productData in responseData) {
          productList.add(ProductModel.fromMap(productData));
        }
      } else {
        throw Exception('Failed to search products');
      }
    } catch (e) {
      print('Error searching products: $e');
      throw e;
    }
    return productList;
  }
}