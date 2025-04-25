import 'package:flutter/material.dart';
import '../../../data/models/cashier_transaction_model.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../../data/models/cashier_order_item_model.dart';
import 'transaction_edit.dart';


class TransactionView extends StatefulWidget{
  final TransactionModel transaction;

  const TransactionView({
    super.key,
    required this.transaction
  });

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final TransactionRepository repo = TransactionRepository();
  late TransactionModel _transaction;
  late List<OrderItem> _orders = [];
  late double _totalAmount = 0;

  @override
  void initState(){
    super.initState();
    _transaction = widget.transaction;
    Future.microtask(() async {
      final response = await repo.fetchOrderItemsByTransactionId(_transaction.id);
      
      setState(() {
        _orders = response;
        for(var order_item in _orders){
          _totalAmount += order_item.quantity * order_item.price;

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 231, 231, 233)
          ),
          Positioned(
            left:0,
            right:0,
            top:100,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 45, horizontal: 30),
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaction ID: ${_transaction.id}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child:IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height:30),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _orders.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _orders[index].product.name,
                                      style: TextStyle(
                                        fontSize: 24
                                      )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity: \t",
                                          style: TextStyle(
                                            color: Colors.grey
                                          )
                                        ),
                                        Text(
                                          _orders[index].quantity.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(width:90),
                                    Row(
                                      children: [
                                        Text(
                                          "Price: \t",
                                          style: TextStyle(
                                            color: Colors.grey
                                          )
                                        ),
                                        Text(
                                          _orders[index].price.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          );
                        }
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(width: 1, color: Colors.black)
                        ),
                        child:SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Total Amount: ₱$_totalAmount",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                              )
                            )
                          )
                        )
                      ),
                      SizedBox(height:45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: (){
                              // delete transaction
                            },
                            child:Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(width:1, color: Colors.black),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: SizedBox(
                                height: 42,
                                width:127,
                                child: Center(child:Text("Delete", style: TextStyle(color: Colors.black, fontSize: 16)))
                              )
                            )
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (_) => TransactionEdit(transaction: _transaction,)));
                            },
                            child:Container(
                              decoration: BoxDecoration(
                                border: Border.all(width:1, color: Colors.black),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: SizedBox(
                                height: 42,
                                width:127,
                                child: Center(child:Text("Edit", style: TextStyle(color: Colors.black, fontSize: 16)))
                              )
                            )
                          ),
                        ],
                      )
                    ] 
                  )
                )
              )
            )
          )
        ],
      )
    );
  }
}