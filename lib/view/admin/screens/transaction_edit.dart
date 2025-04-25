import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/cashier_transaction_model.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../../data/models/cashier_order_item_model.dart';


class TransactionEdit extends StatefulWidget{
  final TransactionModel transaction; 

  const TransactionEdit({
    super.key,
    required this.transaction
  });

  @override
  State<TransactionEdit> createState() => _TransactionEditState();
}

class _TransactionEditState extends State<TransactionEdit> {
  final TransactionRepository repo = TransactionRepository();
  late TransactionModel _transaction;
  late List<OrderItem> _orders = [];
  late List<TextEditingController> _controllers = [];
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
          _controllers.add(TextEditingController());
        }
      });
    });
  }

  void updateTotal(double delta){
    setState((){
      _totalAmount += delta;
    });
  }

  void _getTotal(){
    _totalAmount = 0;
    for(var order_item in _orders){
      _totalAmount += order_item.quantity * order_item.price;
    }
  }

  void _updateTransaction() async{
    var index = 0;
    for(var order_item in _orders){
      order_item.quantity = int.parse(_controllers[index].text);
      index++;
    }
    _getTotal();
    await repo.updateOrderItems(transactionId: _transaction.id, updatedItems: _orders);
    await repo.updateTransactionTotalPrice(_transaction.id, _totalAmount);
    Navigator.popAndPushNamed(context, '/transactions');
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
                padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),
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
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _orders.length,
                        itemBuilder: (context, index){
                          _controllers[index].text = _orders[index].quantity.toString();
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Row(
                                      children: [
                                        Text(
                                          _orders[index].product.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ]
                                    ),
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
                                      ]
                                    )
                                  ]
                                ),
                                Container(
                                  width: 200,
                                  // color: Colors.red,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Quantity:",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                        )
                                      ),
                                      SizedBox(width:10),
                                      SizedBox(
                                        width: 35,
                                        height:20,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0)
                                          ),
                                          onPressed: (){
                                            //minus quantity
                                            if(int.parse(_controllers[index].text) >= 1){
                                              _controllers[index].text = (int.parse(_controllers[index].text)-1).toString();
                                            }
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                              color: Colors.black
                                            )
                                          )
                                        )
                                      ),
                                      SizedBox(width:10),
                                      SizedBox(
                                        width: 35,
                                        height:35,
                                        child:Form(
                                          child:TextFormField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(3)
                                            ],
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left:4),
                                              border: OutlineInputBorder()
                                            ),
                                            controller: _controllers[index],
                                          )
                                        )
                                      ),
                                      SizedBox(width:10),
                                      SizedBox(
                                        width: 35,
                                        height:20,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(0)
                                          ),
                                          onPressed: (){
                                            //plus quantity
                                              _controllers[index].text = (int.parse(_controllers[index].text)+1).toString();
                                          },
                                          child: Text("+")
                                        )
                                      )
                                    ],
                                  ),
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
                              Navigator.pop(context);
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
                                child: Center(child:Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 16)))
                              )
                            )
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: _updateTransaction,
                            child:Container(
                              decoration: BoxDecoration(
                                border: Border.all(width:1, color: Colors.black),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: SizedBox(
                                height: 42,
                                width:127,
                                child: Center(child:Text("Save", style: TextStyle(color: Colors.black, fontSize: 16)))
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