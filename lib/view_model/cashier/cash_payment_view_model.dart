import 'package:flutter/material.dart';

class CashPaymentViewModel extends ChangeNotifier {
  double _cashReceived = 0.0;
  double _totalAmount = 0.0;

  double get cashReceived => _cashReceived;
  double get totalAmount => _totalAmount;
  double get change => (_cashReceived - _totalAmount).clamp(0, double.infinity);

  void setTotalAmount(double amount) {
    _totalAmount = amount;
    notifyListeners();
  }

  void updateCashReceived(String input) {
    _cashReceived = double.tryParse(input) ?? 0.0;
    notifyListeners();
  }

  void reset() {
    _cashReceived = 0.0;
    _totalAmount = 0.0;
    notifyListeners();
  }
}