import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/payment_model.dart';
import '../models/order_item_model.dart'; // Make sure you import the OrderItem model

class PaymentRepository {
  final _client = Supabase.instance.client;

  // Modified to return the inserted transaction's ID
  Future<int> insertPayment(Payment payment) async {
    final data = payment.toMap();
    final response = await _client
        .from('transactions')
        .insert(data)
        .select('id') // Only return the ID
        .single();

    if (response == null || response['id'] == null) {
      throw Exception('Failed to insert payment and retrieve ID.');
    }

    return response['id'] as int;
  }

  // Updated to accept the transactionId and attach it to each order item
  Future<void> insertOrderItems(List<Map<String, dynamic>> orderItems, int transactionId) async {
    final itemsWithTransaction = orderItems.map((item) {
      return {
        ...item,
        'transaction_id': transactionId, // use the int here
      };
    }).toList();

    final response = await _client.from('order_items').insert(itemsWithTransaction);

    if (response == null) {
      throw Exception('Failed to insert order items.');
    }
  }
}
