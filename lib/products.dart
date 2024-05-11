class Products {
    final int id;
    final String name;
    final double price;
    final String imageUrl;

    Products({
        required this.id,
        required this.name,
        required this.price,
        required this.imageUrl,
    });

    factory Products.fromJson(Map<String, dynamic> json) {
        return Products(
            id: json['product_id'] as int,
            name: json['name'] as String,
            price: (json['price'] as num).toDouble(),
            imageUrl: json['image_url'] as String,
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'product_id': id,
            'name': name,
            'price': price,
            'image_url': imageUrl,
        };
    }
}
