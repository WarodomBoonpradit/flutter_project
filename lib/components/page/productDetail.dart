import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
    );
  }
}

class ProductDetail extends StatefulWidget {
  final int productId;

  ProductDetail({required this.productId});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isFavorite = false;
  bool isInCart = false;

  Future<Product> fetchProductDetail() async {
    final response = await http.get(Uri.parse('http://localhost:3000/products/${widget.productId}'));

    if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Product.fromJson(jsonResponse);
    } else {
        throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIGHTYGIZMOS', style: TextStyle(color: Colors.white,),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 49, 92, 1.0),        
      ),
      body: FutureBuilder<Product>(
        future: fetchProductDetail(), // ดึงข้อมูลสินค้า
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product details available'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                    
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: const  BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                      child: ClipRRect(
                        borderRadius: const  BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ชื่อสินค้า
                          Text(
                            product.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          // ราคา
                          Text(
                            '${product.price.toStringAsFixed(2)}฿',
                            style: const TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          const SizedBox(height: 16),
                          // คำอธิบาย
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 16),
                          ),                                                    
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
