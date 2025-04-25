import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import '../widgets/item_card.dart';
import '../../../viewmodels/inventory_item_vm.dart';
import 'package:provider/provider.dart';
import '../widgets/drop_down.dart';
import 'inventory_item_read.dart';
import 'inventory_item_add.dart';
import '../widgets/low_inventory_builder.dart';
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // List<Map<String,dynamic>> items = [];


  @override
  void initState() {
    super.initState();
    Future.microtask((){
      final inventoryVm = context.read<InvenItemViewModel>();

      inventoryVm.getInventoryItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: SingleChildScrollView(
        child:Column(
          children: [
            DropDown(),
            const SizedBox(height: 10),
            
            // ElevatedButton.icon(
            //   onPressed: _addNewItem,
            //   icon: const Icon(Icons.add),
            //   label: const Text("Add New Item"),
            // ),
            LowInventoryBuilder(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:16),
                  child:Text(
                    "Inventory",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)
                  )
                ),

                Padding(
                  padding: EdgeInsets.only(right:16),
                  child:
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InventoryAdd()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                        
                        child: FittedBox(
                          child:Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50
                            )
                          )
                        )
                      )
                    ),
                  )
                )
              ],
            ),
            
            Consumer<InvenItemViewModel>(
              builder: (context, viewModel, child) {
                final items = viewModel.items;
                if (items.isEmpty) {
                  return const Center(child: Text("No items available"));
                }

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(), 
                  shrinkWrap: true, 
                  padding: EdgeInsets.only(top: 15),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final itemFromMap = InventoryItem.fromMap(item);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InventoryView(item: itemFromMap),
                          ),
                        );
                      },
                      child: ItemCard(
                        item: itemFromMap,
                        onDelete: () async {},
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      )
      
      
    );
  }
}
