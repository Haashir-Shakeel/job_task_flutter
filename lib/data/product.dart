
class Product {
  final String productName;
  final String storeName;
  final double price;
  final String category;

  Product({
    required this.productName,
    required this.storeName,
    required this.price,
    required this.category,
  });

  // Convert product to a map
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'storeName': storeName,
      'price': price,
      'category': category,
    };
  }
}