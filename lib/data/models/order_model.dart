import 'order_item_model.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final DateTime createdAt;
  final bool isPaid;

  Order({
    required this.id,
    required this.items,
    required this.createdAt,
    required this.isPaid,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'].toString(),
      items: (map['items'] as List<dynamic>)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      createdAt: DateTime.parse(map['created_at']),
      isPaid: map['is_paid'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'is_paid': isPaid,
    };
  }

  double get totalAmount => items.fold(0.0, (sum, item) => sum + item.totalPrice);
}
