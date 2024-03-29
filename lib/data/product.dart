import 'dart:io';

class Product {
  final String productName;
  final String storeName;
  final double price;
  final String category;
  final List<File> images;

  Product({
    required this.productName,
    required this.storeName,
    required this.price,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'],
      storeName: json['storeName'],
      price: json['price'],
      category: json['category'],
      images: (json['images'] as List).map((path) => File(path)).toList(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'storeName': storeName,
      'price': price,
      'category': category,
      'images': images.map((image) => image.path).toList(),
    };
  }
}
