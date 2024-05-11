import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project/components/page/productDetail.dart';
import 'package:flutter_project/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/favorite_provider.dart';
import 'package:flutter_project/cart_provider.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
    );
  }
}

class keyboardPage extends StatefulWidget {
  @override
  _keyboardPageState createState() => _keyboardPageState();
}

class _keyboardPageState extends State<keyboardPage> {
  Future<List<Products>> fetchProducts() async {
        final response = await http.get(Uri.parse('http://localhost:3000/categorys/2'));

        if (response.statusCode == 200) {
            final List<dynamic> jsonResponse = jsonDecode(response.body);
            return jsonResponse.map((json) => Products.fromJson(json)).toList();
        } else {
            throw Exception('Failed to load products');
        }
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('คีย์บอร์ดทั้งหมด', style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
            ),),
        ),
        body: FutureBuilder<List<Products>>(
            future: fetchProducts(),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                    return const Center(child: Text('ไม่มีสินค้าที่จะแสดง'));
                } else {
                    final products = snapshot.data!;
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                            final product = products[index];
                            return Consumer2<FavoriteProvider, CartProvider>(
                                builder: (context, favoriteProvider, cartProvider, child) {
                                    final isFavorite = favoriteProvider.favoriteProducts.contains(product);
                                    final isInCart = cartProvider.cartItems.contains(product);
                                    return GestureDetector(
                                        onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProductDetail(productId: product.id),
                                                ),
                                            );
                                        },
                                        child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(8),
                                            child: Column(
                                                children: [                                                    
                                                    Container(
                                                        height: 200,
                                                        width: double.infinity,
                                                        child: Image.network(
                                                            product.imageUrl,
                                                            fit: BoxFit.cover,
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                                Center(
                                                                    child: Text(
                                                                        product.name,
                                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 4),
                                                                Center(
                                                                    child: Text('${product.price.toStringAsFixed(2)}฿'),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                            IconButton(
                                                                icon: Icon(
                                                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                                                ),
                                                                color: isFavorite ? Colors.red : Colors.grey,
                                                                onPressed: () {
                                                                    favoriteProvider.toggleFavorite(product);
                                                                },
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                    isInCart ? Icons.shopping_cart : Icons.shopping_cart,
                                                                ),
                                                                color: isInCart ? Colors.green : Colors.grey,
                                                                onPressed: () {
                                                                    cartProvider.addProduct(product);
                                                                },
                                                            ),
                                                        ],
                                                    ),
                                                ],
                                            ),
                                        ),
                                    );
                                },
                            );
                        },
                    );
                }
            },
        ),
    );
}
}