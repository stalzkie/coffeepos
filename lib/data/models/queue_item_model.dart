import 'package:flutter/material.dart';

class CashPaymentViewModel extends ChangeNotifier {
  double _customerAmount = 0.0;
  double _totalAmount = 0.0;

  void setTotalAmount(double total) {
    _totalAmount = total;
    notifyListeners();
  }

  void setCustomerAmount(double value) {
    _customerAmount = value;
    notifyListeners();
  }

  double get change => _customerAmount - _totalAmount;

  void reset() {
    _customerAmount = 0.0;
    _totalAmount = 0.0;
    notifyListeners();
  }
}
