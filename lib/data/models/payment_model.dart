enum PaymentMethod {
  gcash,
  cash,
  unknown,
}

class Payment {
  final String id;
  final String orderId;
  final PaymentMethod method;
  final bool confirmed;

  Payment({
    required this.id,
    required this.orderId,
    required this.method,
    required this.confirmed,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'].toString(),
      orderId: map['order_id'].toString(),
      method: _methodFromString(map['method']),
      confirmed: map['confirmed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'method': method.name,
      'confirmed': confirmed,
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
