import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../view_model/customer/order_view_model.dart';
import '../../../data/models/order_item_model.dart';

class CustomerThankYouScreen extends StatelessWidget {
  const CustomerThankYouScreen({super.key});

  Future<void> saveOrderToSupabase(List<OrderItem> orderItems) async {
    final client = supabase.Supabase.instance.client;

    final totalAmount = orderItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    // Step 1: Insert into `transactions` table
    final txResponse = await client
        .from('transactions')
        .insert({
          'total_price': totalAmount,
          'payment_method': 'cash', // You can pass actual value
          'created_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    final transactionId = txResponse['id'];

    // Step 2: Insert each order item into `order_items` table
    final orderRows = orderItems.map((item) => {
          'transaction_id': transactionId,
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price,
        });

    await client.from('order_items').insert(orderRows.toList());
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        children: [
          // 🟤 Header
          Container(
            height: 99,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Text(
                'sonofabean.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const Spacer(),

          // 🎉 Message
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Thank you for your order, sonofabean!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ✅ Confirm Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () async {
                await saveOrderToSupabase(orderVM.orderItems);
                orderVM.clearOrder();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/menu',
                  (route) => false,
                );
              },
              child: Container(
                width: 284,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF62FF6D),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Back To Main Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Figtree',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
