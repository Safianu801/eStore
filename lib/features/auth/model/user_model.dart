import 'dart:convert';

import 'package:e_store/features/e_commerce/cart/model/cart_model.dart';

class UserModel {
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final List<CartModel> cart;

  UserModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.cart,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userID: map['userID'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
      cart: List<CartModel>.from(
          map['cart']?.map((x) => CartModel.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'cart': cart.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? userID,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    List<CartModel>? cart,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      cart: cart ?? this.cart,
    );
  }
}
