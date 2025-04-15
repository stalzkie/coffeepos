import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/cashier/transaction_view_model.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final double totalPrice;
  final String transactionId;

  const ConfirmPaymentScreen({
    super.key,
    required this.totalPrice,
    required this.transactionId,
  });

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  final TextEditingController _cashController = TextEditingController();
  double? change;

  void _calculateChange(String value) {
    final cash = double.tryParse(value);
    if (cash != null && cash >= widget.totalPrice) {
      setState(() => change = cash - widget.totalPrice);
    } else {
      setState(() => change = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionVM = Provider.of<TransactionViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Payment',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Total Price: ₱${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _cashController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cash Received',
                border: OutlineInputBorder(),
              ),
              onChanged: _calculateChange,
            ),
            const SizedBox(height: 20),

            if (change != null)
              Text(
                'Change: ₱${change!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const Spacer(),

            GestureDetector(
              onTap: () async {
                if (change == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid or insufficient cash input')),
                  );
                  return;
                }

                final success = await transactionVM.markTransactionAsPaidById(widget.transactionId);
                if (success && context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/cashier/thankYou',
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update transaction status')),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
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
          ],
        ),
      ),
    );
  }
}
