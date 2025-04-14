import 'package:flutter/material.dart';
import '../../../data/models/cashier_transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.tryParse(transaction.createdAt as String)?.toLocal();
    final formattedDate = createdAt != null
        ? DateFormat('yyyy-MM-dd – hh:mm a').format(createdAt)
        : 'Invalid date';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔢 Transaction ID
            Text(
              'Transaction ID: ${transaction.id}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            // 💰 Total Price
            Text(
              'Total: ₱${transaction.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
              ),
            ),

            // 🧾 Mode of Payment
            Text(
              'Payment: ${transaction.paymentMethod}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),

            // 🕒 Timestamp
            Text(
              'Created: $formattedDate',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Figtree',
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
