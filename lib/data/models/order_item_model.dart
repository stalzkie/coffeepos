import 'product_model.dart';

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  double get totalPrice => product.price * quantity;
}
