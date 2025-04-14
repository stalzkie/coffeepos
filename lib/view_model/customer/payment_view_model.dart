import 'package:flutter/material.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/models/order_item_model.dart';  // Make sure you import the OrderItem model

class PaymentViewModel extends ChangeNotifier {
  final PaymentRepository _repository = PaymentRepository();

  PaymentMethod _selectedMethod = PaymentMethod.unknown;
  PaymentMethod get selectedMethod => _selectedMethod;

  void selectMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  Future<void> confirmPayment({
    required double totalPrice,
    required List<OrderItem> orderItems,
  }) async {
    final payment = Payment(
      totalPrice: totalPrice,
      paymentMethod: _selectedMethod,
      status: 'pending',
    );

    // Insert payment and get the transaction ID
    final transactionId = await _repository.insertPayment(payment);

    // Prepare and insert order items with the transaction ID
    final orderItemList = orderItems.map((item) {
      return {
        'product_id': item.product.id,
        'quantity': item.quantity,
        'price': item.totalPrice,
      };
    }).toList();

    await _repository.insertOrderItems(orderItemList, transactionId);
  }
}
