class TransactionModel {
  final String id;
  final double totalPrice;
  final String paymentMethod;
  final DateTime createdAt;
  final String status; // Add the status field

  TransactionModel({
    required this.id,
    required this.totalPrice,
    required this.paymentMethod,
    required this.createdAt,
    required this.status, // Add status to the constructor
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      paymentMethod: json['payment_method'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'] ?? 'unpaid', // Default to 'unpaid' if not available
    );
  }
}
