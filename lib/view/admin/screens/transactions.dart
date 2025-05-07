import 'package:flutter/material.dart';
import '../widgets/drop_down.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../../data/models/cashier_transaction_model.dart';
import 'transaction_view.dart';


class TransactionScreen extends StatefulWidget{
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionRepository _repo = TransactionRepository();
  List<TransactionModel> _transactions = [];
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final data = await _repo.fetchTransactionsNoFilter("","");
      setState(() {
        _transactions = data;
      });
    });
  }

  String formatDateCreated(DateTime date){
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  
    return '${date.day} ${months[date.month-1]}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          DropDown(),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(94, 0, 0, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children:[
                  Container(
                    width:307,
                    color: const Color.fromARGB(149, 255, 255, 255),
                    child: TextField(
                      controller: search,
                      decoration: const InputDecoration(
                        hintText: "Search transaction...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      final response = await _repo.searchTransactions(search.text);
                      
                      setState(() {
                        _transactions = response;
                      });
                    },
                    child: Icon(Icons.search, size: 30,)
                  )
                ]
              )
            ),
          ),

          const SizedBox(height: 16),

          ..._transactions.map((tx) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TransactionView(transaction: tx),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction ID: ${tx.id}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price: ${tx.totalPrice}"),
                      Text("Date: ${formatDateCreated(tx.createdAt)} "),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}