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

Future<List<TransactionModel>> fetchTransactionsNoFilter(String startDate, String endDate) async {
  var query = _client
  .from('transactions')
  .select()
  .eq('status', 'paid');
  if (startDate != "") query = query.gte('created_at', "${startDate} 00:00:00");
  if (endDate != "") query = query.lt('created_at', "${endDate} 23:59:59");

  // query = query.order('created_at', ascending: false);
  final response = await query;
  return (response as List)
      .map((json) => TransactionModel.fromJson(json))
      .toList();
}

  Future<List<TransactionModel>> searchTransactions(String query) async {
    if(query != ""){
      final response = await _client
        .from('transactions')
        .select()
        .eq('id', int.parse(query))
        .eq('status', 'paid') // Fetch only unpaid transactions
        .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    }else{
      return fetchTransactionsNoFilter("","");
    }
  }

  Future<List<OrderItem>> fetchOrderItemsByTransactionId(String transactionId) async {
    final response = await _client
        .from('order_items')
        .select('*, product:products(*)')
        .eq('transaction_id', transactionId);

    return (response as List).map((json) => OrderItem.fromJson(json)).toList();
  }

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

  Future<void> updateTransactionTotalPrice(String transactionId, double newTotal) async {
    await _client
        .from('transactions')
        .update({'total_price': newTotal})
        .eq('id', transactionId);
  }

  Future<void> markTransactionAsPaid(String transactionId) async {
    await _client
        .from('transactions')
        .update({'status': 'paid'}) // ✅ Make sure this field is updated
        .eq('id', transactionId);
  }

  Future<void> deleteTransactionFromID(String transactionID) async {
    try{
      await _client.from('transactions').delete().eq('id', transactionID);
    }catch (e){
      print("error with deleting transaction:$e");
    }
  }
}
