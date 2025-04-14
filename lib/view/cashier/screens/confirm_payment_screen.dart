import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/cashier/transaction_view_model.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final double? totalPrice;

  const ConfirmPaymentScreen({super.key, this.totalPrice});

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  final TextEditingController _cashController = TextEditingController();
  double? change;
  late double total;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    total = widget.totalPrice ??
        ModalRoute.of(context)?.settings.arguments as double? ??
        0.0;
  }

  void _calculateChange(String value) {
    final cash = double.tryParse(value);
    if (cash != null && cash >= total) {
      setState(() => change = cash - total);
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
              'Total Price: ₱${total.toStringAsFixed(2)}',
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
                if (change != null) {
                  try {
                    await transactionVM.markAsPaid(); // ✅ mark as paid

                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/thankYou',
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to mark as paid: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid or insufficient cash input')),
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
