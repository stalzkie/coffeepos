import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/customer/payment_view_model.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/order_item_model.dart'; // <-- Add this import
import '../../../view_model/customer/order_view_model.dart';

class ChoosePaymentScreen extends StatelessWidget {
  final double totalPrice;
  final List<OrderItem> orderItems;  // Use OrderItem as the type

  const ChoosePaymentScreen({
    super.key,
    required this.totalPrice,
    required this.orderItems,  // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    final paymentVM = Provider.of<PaymentViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        children: [
          // 🔲 Header
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

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose your\nPayment Method',
                textAlign: TextAlign.left,
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                _buildOption(
                  label: 'Gcash/QR Code',
                  isSelected: paymentVM.selectedMethod == PaymentMethod.gcash,
                  onTap: () => paymentVM.selectMethod(PaymentMethod.gcash),
                ),
                const SizedBox(height: 20),
                _buildOption(
                  label: 'Cash Payment',
                  isSelected: paymentVM.selectedMethod == PaymentMethod.cash,
                  onTap: () => paymentVM.selectMethod(PaymentMethod.cash),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 274,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Back To Orders',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: GestureDetector(
              onTap: () async {
                // Retrieve the order items from the OrderViewModel
                final orderItems = Provider.of<OrderViewModel>(context, listen: false).orderItems;

                // Confirm the payment with the selected total price and the orderItems
                await paymentVM.confirmPayment(
                  totalPrice: totalPrice,
                  orderItems: orderItems, // Pass the order items here
                );

                // Based on the selected payment method, navigate to the appropriate screen
                if (paymentVM.selectedMethod == PaymentMethod.cash) {
                  // Navigate to the thank you screen
                  Navigator.pushNamed(context, '/thankYou');
                } else if (paymentVM.selectedMethod == PaymentMethod.gcash) {
                  // Navigate to the QR code screen
                  Navigator.pushNamed(context, '/qrCode');
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF63FF6D),
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

  Widget _buildOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
