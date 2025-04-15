import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/cashier_order_item_model.dart';
import '../../../view_model/cashier/transaction_view_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TransactionViewModel>(context);
    final orderItems = viewModel.orderItems;

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header
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
                      'Transaction Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Product List
                Expanded(
                  child: orderItems.isEmpty
                      ? const Center(child: Text('No items in this transaction.'))
                      : ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemCount: orderItems.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 15),
                          itemBuilder: (context, index) {
                            final item = orderItems[index];
                            final imageUrl = item.product.imageUrl;

                            return Dismissible(
                              key: ValueKey(item.product.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) {
                                viewModel.removeOrderItem(item.product.id);
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                color: Colors.red,
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                              child: GestureDetector(
                                onTap: () => _showEditDialog(context, viewModel, item),
                                child: Container(
                                  height: 131,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 2, color: Colors.black),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(85.32),
                                        child: Image.network(
                                          imageUrl,
                                          width: 93,
                                          height: 93,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            width: 93,
                                            height: 93,
                                            color: const Color(0xFFCCCCCC),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Figtree',
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '₱${item.price.toStringAsFixed(2)} · ${item.quantity} pcs',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Figtree',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1E1E1E),
                            side: const BorderSide(width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Back to Transactions'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/cashier/confirmPayment',
                              arguments: {
                                  'totalPrice': viewModel.totalPrice,
                                  'transactionId': viewModel.selectedTransaction?.id ?? '',
                                },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF62FF6D),
                            foregroundColor: Colors.black,
                            side: const BorderSide(width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Confirm Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

void _showEditDialog(BuildContext context, TransactionViewModel viewModel, OrderItem item) {
  final TextEditingController qtyController = TextEditingController(text: item.quantity.toString());

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Edit ${item.product.name}'),
      content: TextField(
        controller: qtyController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Quantity'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final newQty = int.tryParse(qtyController.text);
            if (newQty != null && newQty > 0) {
              viewModel.updateQuantity(item.id, newQty);      // ✅ Updates local state
              await viewModel.saveChanges();                  // ✅ Persists to Supabase
            }
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    ),
  );
}
}