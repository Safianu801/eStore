import 'dart:convert';

import 'package:e_store/features/auth/forgot_password/screens/forgot_password_success_screen.dart';
import 'package:e_store/features/auth/sign_up/screens/registration_success_screen.dart';
import 'package:e_store/utilities/constant/app_strings.dart';
import 'package:e_store/utilities/shared_components/httpErrorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../e_commerce/shop/screens/shop_screen.dart';
import '../model/user_provider.dart';

class AuthService extends ChangeNotifier {
  String baseUrl = AppStrings.liveUrl;

  Future<void> registerUser(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response =
          await http.post(Uri.parse("$baseUrl/api/v1/e-stores/users/register"),
              headers: {"Content-Type": "application/json"},
              body: json.encode({
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "password": password
              }));
      if (response.statusCode == 201) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const RegistrationSuccessScreen()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User registration failed")));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> userLogin(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/v1/e-stores/users/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var responseBody = jsonDecode(response.body);
            var userJson = responseBody['user'];
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonEncode(userJson));
            String? token = userJson['token'];
            String? userID = userJson['userID'];
            if (token != null && userID != null) {
              await prefs.setString('Authorization', token);
              await prefs.setString('user', userID);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ShopScreen(),
              ));
            } else {
              print("Error: token or userID is null");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Login failed. Please try again.")),
              );
            }
          });
    } catch (err) {
      throw (err);
    }
  }

  Future<void> resetPassword(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/api/v1/e-stores/users/reset-password"),
      headers: {
        "Content-Type": "application/json"
      },
        body: json.encode({
          "email": email,
          "newPassword": password
        })
      );
      httpErrorHandler(response: response, context: context, onSuccess: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ForgotPasswordSuccessScreen()), (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }
}
