import 'product_model.dart';

class OrderItem {
  final String id;
  final String transactionId;
  final Product product;
  int quantity;
  final double price;

  OrderItem({
    required this.id,
    required this.transactionId,
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'].toString(),
      transactionId: json['transaction_id'].toString(),
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  OrderItem copyWith({
    String? id,
    String? transactionId,
    Product? product,
    int? quantity,
    double? price,
  }) {
    return OrderItem(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
