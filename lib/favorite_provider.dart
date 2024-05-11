import 'package:flutter/foundation.dart';
import 'package:flutter_project/products.dart';

class FavoriteProvider extends ChangeNotifier {
    // Set<Products> เพื่อเก็บสินค้าที่เป็นรายการโปรด
    Set<Products> favoriteProducts = {};

    // ฟังก์ชันเพื่อเพิ่มหรือลบสินค้าใน favoriteProducts
    void toggleFavorite(Products product) {
        if (favoriteProducts.contains(product)) {
            favoriteProducts.remove(product);
        } else {
            favoriteProducts.add(product);
        }
        // แจ้งให้ผู้ที่ใช้ Provider นี้ทราบว่ามีการเปลี่ยนแปลง
        notifyListeners();
    }
}
