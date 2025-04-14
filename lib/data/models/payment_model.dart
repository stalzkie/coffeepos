enum PaymentMethod {
  gcash,
  cash,
  unknown,
}

class Payment {
  final String? id; // optional
  final double totalPrice;
  final PaymentMethod paymentMethod;
  final String status;
  final DateTime createdAt;

  Payment({
    this.id,
    required this.totalPrice,
    required this.paymentMethod,
    this.status = 'pending',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id']?.toString(),
      totalPrice: (map['total_price'] is num)
          ? (map['total_price'] as num).toDouble()
          : double.parse(map['total_price'].toString()),
      paymentMethod: _methodFromString(map['payment_method']),
      status: map['status'] ?? 'pending',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_price': totalPrice,
      'payment_method': paymentMethod.name,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static PaymentMethod _methodFromString(String? str) {
    switch (str?.toLowerCase()) {
      case 'gcash':
        return PaymentMethod.gcash;
      case 'cash':
        return PaymentMethod.cash;
      default:
        return PaymentMethod.unknown;
    }
  }
}
