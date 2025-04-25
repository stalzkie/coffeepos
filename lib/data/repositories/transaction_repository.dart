import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/cashier_transaction_model.dart';
import '../../../data/models/cashier_order_item_model.dart';

class TransactionRepository {
  final _client = Supabase.instance.client;

Future<List<TransactionModel>> fetchAllTransactions() async {
  final response = await _client
      .from('transactions')
      .select()
      .eq('payment_status', 'unpaid') // ✅ Filter here
      .order('created_at', ascending: false);

  return (response as List)
      .map((json) => TransactionModel.fromJson(json))
      .toList();
}

Future<List<TransactionModel>> fetchTransactionsNoFilter() async {
  final response = await _client
      .from('transactions')
      .select()
      .eq('status', 'paid')
      .order('created_at', ascending: false);

  return (response as List)
      .map((json) => TransactionModel.fromJson(json))
      .toList();
}

  // Search transactions by ID for unpaid ones
  Future<List<TransactionModel>> searchTransactions(String query) async {
    final response = await _client
        .from('transactions')
        .select()
        .ilike('id', '%$query%')
        .eq('status', 'unpaid') // Fetch only unpaid transactions
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => TransactionModel.fromJson(json))
        .toList();
  }

  // Fetch order items by transaction ID
  Future<List<OrderItem>> fetchOrderItemsByTransactionId(String transactionId) async {
    final response = await _client
        .from('order_items')
        .select('*, product:products(*)')
        .eq('transaction_id', transactionId);

    return (response as List).map((json) => OrderItem.fromJson(json)).toList();
  }

  // Update order items in the database
  Future<void> updateOrderItems({
    required String transactionId,
    required List<OrderItem> updatedItems,
  }) async {
    for (final item in updatedItems) {
      await _client
          .from('order_items')
          .update({'quantity': item.quantity})
          .eq('id', item.id);
    }

    final newTotal = updatedItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    await updateTransactionTotalPrice(transactionId, newTotal);
  }

  // Update the total price of a transaction
  Future<void> updateTransactionTotalPrice(String transactionId, double newTotal) async {
    await _client
        .from('transactions')
        .update({'total_price': newTotal})
        .eq('id', transactionId);
  }

  // Mark the transaction as paid
  Future<void> markTransactionAsPaid(String transactionId) async {
    await _client
        .from('transactions')
        .update({'status': 'paid'}) // ✅ Make sure this field is updated
        .eq('id', transactionId);
  }
}
