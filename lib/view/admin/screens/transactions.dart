import 'package:flutter/material.dart';
import '../widgets/drop_down.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../../data/models/cashier_transaction_model.dart';
import '../../../data/models/cashier_order_item_model.dart';
import 'transaction_view.dart';


class TransactionScreen extends StatefulWidget{
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionRepository _repo = TransactionRepository();
  List<TransactionModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final data = await _repo.fetchTransactionsNoFilter();
      setState(() {
        _transactions = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E9),
      body: Column(
          children: [
            // Header
            DropDown(),
            // Title
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search transaction...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ),

            SizedBox(height:16),

            // Transactions list
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _transactions.length, // Replace with your real data
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      // redirect to transact details
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (_) => TransactionView(transaction: _transactions[index])));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transaction ID: ${_transactions[index].id}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price: ${_transactions[index].totalPrice}"),
                                Text("Date: ${_transactions[index].createdAt}"),
                              ],
                            ),
                          ],
                        ),
                    )
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}