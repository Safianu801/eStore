import 'package:e_store/features/e_commerce/shop/model/product_model.dart';

class CartModel {
  final String itemID;
  final String owner;
  final ProductModel product;
  final int totalQuantity;

  CartModel({
    required this.itemID,
    required this.owner,
    required this.product,
    required this.totalQuantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      itemID: map['itemID'] ?? '',
      owner: map['owner'] ?? '',
      product: ProductModel.fromMap(map['product'] ?? {}),
      totalQuantity: map['totalQuantity'] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'itemID': itemID,
      'owner': owner,
      'product': product.toMap(),
      'totalQuantity': totalQuantity,
    };
  }
}
