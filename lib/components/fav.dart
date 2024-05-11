import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/favorite_provider.dart';
import 'package:flutter_project/components/page/productDetail.dart';

class FavoritePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final favoriteProvider = Provider.of<FavoriteProvider>(context);
        final favoriteProducts = favoriteProvider.favoriteProducts;

        return Scaffold(
            appBar: AppBar(
                title: const Text('สินค้าโปรดของคุณ', style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
            body: favoriteProducts.isEmpty
                ? const Center(child: Text('คุณยังไม่มีสินค้าโปรด'))
                : ListView.builder(
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                        final product = favoriteProducts.elementAt(index);
                        
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
                                        // เรียก favoriteProvider.toggleFavorite(product) เพื่ออัปเดตสถานะของสินค้า
                                        favoriteProvider.toggleFavorite(product);
                                    },
                                ),
                                onTap: () {
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
        );
    }
}
