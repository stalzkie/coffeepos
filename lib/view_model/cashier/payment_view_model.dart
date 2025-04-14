import 'package:flutter/material.dart';

enum PaymentMethod { cash, qr }

class PaymentViewModel extends ChangeNotifier {
  PaymentMethod? _selectedMethod;

  PaymentMethod? get selectedMethod => _selectedMethod;

  void selectMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  void reset() {
    _selectedMethod = null;
    notifyListeners();
  }
}