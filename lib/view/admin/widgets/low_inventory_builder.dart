import 'package:coffee_inventory_app/data/models/inventory_item.dart';
import 'package:coffee_inventory_app/viewmodels/inventory_item_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/inventory_item_read.dart';

class LowInventoryBuilder extends StatefulWidget{
  const LowInventoryBuilder({super.key});
  @override
  State<LowInventoryBuilder> createState() => _LowInventoryBuilderState();
}

class _LowInventoryBuilderState extends State<LowInventoryBuilder> {
  late Map<String, dynamic> _lowInventory = <String,dynamic>{};

  late InvenItemViewModel _vm;
  @override
  void initState(){
    super.initState();
    _vm = context.read<InvenItemViewModel>();
    print("\nQUERIED\n");
    Future.microtask(() async {
      final response = await _vm.getLowInventoryItems() ?? _lowInventory;
      setState((){
        _lowInventory = response;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    if(_lowInventory.isEmpty){
      return SizedBox(width: 0, height: 0);
    }
    return Column(
      children:[
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left:16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    "Alert!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.0                    
                    )
                  ),
                  Text(
                    "Low Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.0 
                    )
                  ),
                ]
              )
            ),
          ],
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InventoryView(item: InventoryItem.fromMap(_lowInventory)))
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width:1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Inventory Name: ${_lowInventory['name']}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      ),
                      Row(
                        children: [
                          Text(
                            "Quantity: ${_lowInventory['quantity']}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      ),
                    ]
                  )
                )
              )
            )
          )
        )    
      ]
    );
  }
}