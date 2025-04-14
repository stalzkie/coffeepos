import 'package:flutter/material.dart';
import '../../data/models/cashier_transaction_model.dart';
import '../../data/models/cashier_order_item_model.dart';
import '../../data/repositories/transaction_repository.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();

  TransactionModel? _selectedTransaction;
  List<OrderItem> _orderItems = [];
  bool _isLoading = false;

  TransactionModel? get selectedTransaction => _selectedTransaction;
  List<OrderItem> get orderItems => _orderItems;
  bool get isLoading => _isLoading;

  void setTransaction(TransactionModel transaction) async {
    _selectedTransaction = transaction;
    await loadOrderItems(transaction.id);
    notifyListeners();
  }

  Future<void> loadOrderItems(String transactionId) async {
    _isLoading = true;
    notifyListeners();

    _orderItems = await _repository.fetchOrderItemsByTransactionId(transactionId); // ✅ correct method name

    _isLoading = false;
    notifyListeners();
  }

  void updateQuantity(String orderItemId, int newQty) {
  final index = _orderItems.indexWhere((item) => item.id == orderItemId);
  if (index != -1) {
    final updatedItem = _orderItems[index].copyWith(quantity: newQty);
    _orderItems[index] = updatedItem;
    notifyListeners();
  }
}

  void removeOrderItem(String orderItemId) {
    _orderItems.removeWhere((item) => item.id == orderItemId);
    notifyListeners();
  }

  double get totalPrice {
    return _orderItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  Future<void> saveChanges() async {
    if (_selectedTransaction == null) return;

    await _repository.updateOrderItems(
      transactionId: _selectedTransaction!.id,
      updatedItems: _orderItems,
    );

    await _repository.updateTransactionTotalPrice(
      _selectedTransaction!.id,
      totalPrice,
    );
}
  Future<void> recordTransactionToSupabase() async {
    if (_selectedTransaction == null) return;

    await _repository.markTransactionAsPaid(_selectedTransaction!.id);
  }
}
