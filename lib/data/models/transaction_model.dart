import 'order_model.dart';

class TransactionModel {
  final String id;
  final DateTime createdAt;
  final double totalPrice;
  List<Order> orders;

  TransactionModel({
    required this.id,
    required this.createdAt,
    required this.totalPrice,
    required this.orders,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map, List<Order> orders) {
    return TransactionModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
      orders: orders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'total_price': totalPrice,
    };
  }
}
