import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../view_model/customer/order_view_model.dart';
import '../../../data/models/order_item_model.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  final String qrImageUrl =
      'https://uolinrriyhezsqzefkpi.supabase.co/storage/v1/object/public/qr-codes/payment-qr.png';

  Future<void> saveOrderToSupabase(List<OrderItem> orderItems) async {
    final client = supabase.Supabase.instance.client;

    final totalAmount = orderItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    // 1. Save to transactions table
    final txResponse = await client
        .from('transactions')
        .insert({
          'total_price': totalAmount,
          'payment_method': 'gcash',
          'created_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    final transactionId = txResponse['id'];

    // 2. Save order items
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

          const SizedBox(height: 50),

          // 📢 Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please Scan \nThe QR Code',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Figtree',
                  height: 1.25,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // 📷 QR Code Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 322,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  qrImageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.qr_code_2, size: 100, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),

          // ✅ Confirm Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: GestureDetector(
              onTap: () async {
                await saveOrderToSupabase(orderVM.orderItems);
                orderVM.clearOrder();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/thankYou',
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF62FF6D),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Confirm Payment',
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
        ],
      ),
    );
  }
}
