import 'package:flutter/material.dart';
import '../../../data/models/payment_model.dart';

class CustomerPaymentViewModel extends ChangeNotifier {
  PaymentMethod _selectedMethod = PaymentMethod.unknown;
  PaymentMethod get selectedMethod => _selectedMethod;

  bool _isConfirmed = false;
  bool get isConfirmed => _isConfirmed;

  void selectPaymentMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  void confirmPayment() {
    if (_selectedMethod != PaymentMethod.unknown) {
      _isConfirmed = true;
      notifyListeners();
    }
  }

  void reset() {
    _selectedMethod = PaymentMethod.unknown;
    _isConfirmed = false;
    notifyListeners();
  }
}
