import 'package:flutter/foundation.dart';
import 'package:flutter_project/products.dart';

class CartProvider extends ChangeNotifier {    
    List<Products> cartItems = [];
    void addProduct(Products product) {
        cartItems.add(product);
        notifyListeners();
    }
    void removeProduct(Products product) {
        cartItems.remove(product);
        notifyListeners();
    }
}
