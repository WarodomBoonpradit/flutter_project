import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/cart_provider.dart';
import 'package:flutter_project/components/page/productDetail.dart'; // นำเข้า ProductDetail

class CartPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final cartProvider = Provider.of<CartProvider>(context);
        final cartItems = cartProvider.cartItems;

        // คำนวณราคารวมของสินค้าที่อยู่ในรถเข็น
        double totalPrice = cartItems.fold(0.0, (sum, product) => sum + product.price);

        return Scaffold(
            appBar: AppBar(
                title: const Text('รถเข็นของคุณ', style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
            body: cartItems.isEmpty
                ? const Center(child: Text('รถเข็นของคุณว่างเปล่า'))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                    ),
                                ],
                            ),
                            child: ListTile(
                                leading: Image.network(product.imageUrl, width: 50, height: 50),
                                title: Text(product.name),
                                subtitle: Text('${product.price.toStringAsFixed(2)}฿'),
                                trailing: IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                    onPressed: () {
                                        // ใช้ cartProvider เพื่อลบสินค้าออกจากรถเข็น
                                        cartProvider.removeProduct(product);
                                    },
                                ),
                                onTap: () {
                                    // นำทางไปยังหน้า ProductDetail พร้อมส่ง product.id
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductDetail(productId: product.id),
                                        ),
                                    );
                                },
                            ),
                        );
                    },
                ),
            bottomNavigationBar: BottomAppBar(
                child: Container(                  
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5, 
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                            ),
                        ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'ราคารวม: ${totalPrice.toStringAsFixed(2)}฿',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                    ),
                ),
            ),
        );
    }
}
