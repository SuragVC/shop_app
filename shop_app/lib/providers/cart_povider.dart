import 'package:flutter/material.dart';
import 'package:shop_app/schemas.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartList = [];

  get cartList => _cartList;

  void setProductToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cartList.remove(product);
    notifyListeners();
  }
}
