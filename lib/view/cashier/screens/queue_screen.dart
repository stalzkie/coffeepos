import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/cashier/queue_view_model.dart';
import '../../../view_model/cashier/transaction_view_model.dart';
import 'transaction_detail_screen.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({super.key});

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<QueueViewModel>(context, listen: false);
      vm.fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final queueVM = Provider.of<QueueViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: const Align(
              alignment: Alignment.center,
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

          const SizedBox(height: 20),

          // 🧾 Title and Back Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Customer Orders',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Figtree',
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),

          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextField(
              onChanged: queueVM.updateSearchQuery,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for transaction ID....',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF525252),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),

          // 📋 Transaction List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: queueVM.filteredTransactions.isEmpty
                  ? const Center(child: Text("No transactions found."))
                  : ListView.separated(
                      itemCount: queueVM.filteredTransactions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tx = queueVM.filteredTransactions[index];

                        return GestureDetector(
                          onTap: () {
                            final transactionVM =
                                Provider.of<TransactionViewModel>(context,
                                    listen: false);
                            transactionVM.setTransaction(tx);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TransactionDetailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction ID: ${tx.id}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Figtree',
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text('Total: ₱${tx.totalPrice.toStringAsFixed(2)}'),
                                Text('Payment: ${tx.paymentMethod}'),
                                Text('Date: ${tx.createdAt.toLocal()}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
