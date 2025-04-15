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

  // Sets the active transaction and loads its order items
  Future<void> setTransaction(TransactionModel transaction) async {
    _selectedTransaction = transaction;
    await loadOrderItems(transaction.id);
    notifyListeners();
  }

  // Loads order items for a transaction
  Future<void> loadOrderItems(String transactionId) async {
    _isLoading = true;
    notifyListeners();

    _orderItems = await _repository.fetchOrderItemsByTransactionId(transactionId);

    _isLoading = false;
    notifyListeners();
  }

  // Update quantity of a single order item
  void updateQuantity(String orderItemId, int newQty) {
    final index = _orderItems.indexWhere((item) => item.id == orderItemId);
    if (index != -1) {
      final updatedItem = _orderItems[index].copyWith(quantity: newQty);
      _orderItems[index] = updatedItem;
      notifyListeners();
    }
  }

  // Remove an item from the transaction
  void removeOrderItem(String orderItemId) {
    _orderItems.removeWhere((item) => item.id == orderItemId);
    notifyListeners();
  }

  // Calculates the total price of all order items
  double get totalPrice {
    return _orderItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  // Save changes to order items and update the transaction total
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

  // Records payment for the currently selected transaction
  Future<void> recordTransactionToSupabase() async {
    if (_selectedTransaction == null) return;
    await _repository.markTransactionAsPaid(_selectedTransaction!.id);
  }

  // ✅ NEW: Marks a transaction as paid directly by ID (used in ConfirmPaymentScreen)
  Future<bool> markTransactionAsPaidById(String id) async {
    try {
      await _repository.markTransactionAsPaid(id);
      return true;
    } catch (e) {
      debugPrint('Error marking transaction as paid: $e');
      return false;
    }
  }
}
