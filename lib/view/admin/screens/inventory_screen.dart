import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import '../widgets/item_card.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../viewmodels/inventory_item_vm.dart';
import 'package:provider/provider.dart';
import '../widgets/drop_down.dart';
import 'edit_inventory_item.dart';
import 'add_inventory_item.dart';
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

  // Calculate remaining stock dynamically based on sales
  // int _calculateRemaining(InventoryItem item) {
  //   int totalSold = salesBox.values
  //       .where((sale) => sale.itemName == item.name)
  //       .fold(0, (sum, sale) => sum + sale.quantitySold);
  //   return item.quantity - totalSold;
  // }

  Future<void> _addNewItem() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    XFile? pickedImage;

    await showDialog(
      context: context,
      builder: (context) => Consumer<InvenItemViewModel>(
        builder: (context, viewModel, child){
          return AlertDialog(
            title: const Text("Add New Item"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price"),
                  ),
                  TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Quantity"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Image (Optional)"),
                    onPressed: () async {
                      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      quantityController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please fill all required fields.");
                    return;
                  }

                  String? imagePath;
                  if (pickedImage != null) {
                    final appDir = await getApplicationDocumentsDirectory();
                    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
                    final savedImage = await File(pickedImage!.path)
                        .copy('${appDir.path}/$fileName.jpg');
                    imagePath = savedImage.path;
                  }

                  final item = InventoryItem(
                    name: nameController.text,
                    description: descController.text,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    quantity: int.tryParse(quantityController.text) ?? 0,
                    imagePath: imagePath ?? '',
                  );

                  viewModel.addInventoryItem(item);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text("Add Item"),
              ),
            ],
          );
        }),
      
    );
  }

  Future<void> _showEditItemDialog(InventoryItem item, int index) async {
    final TextEditingController nameController = TextEditingController(text: item.name);
    final TextEditingController descController = TextEditingController(text: item.description);
    final TextEditingController priceController = TextEditingController(text: item.price.toString());
    final TextEditingController quantityController = TextEditingController(text: item.quantity.toString());
    XFile? pickedImage;

    await showDialog(
      context: context,
      builder: (context) => Consumer<InvenItemViewModel>(
        builder: (context, viewModel, child){
          return AlertDialog(
            title: const Text("Edit Item"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Change Image (Optional)"),
                    onPressed: () async {
                      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please fill all required fields.");
                    return;
                  }

                  String? imagePath = item.imagePath;
                  if (pickedImage != null) {
                    final appDir = await getApplicationDocumentsDirectory();
                    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
                    final savedImage = await File(pickedImage!.path)
                        .copy('${appDir.path}/$fileName.jpg');
                    imagePath = savedImage.path;
                  }

                  final updatedItem = InventoryItem(
                    id: item.id!,
                    name: nameController.text,
                    description: descController.text,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    quantity: int.tryParse(quantityController.text) ?? 0,
                    imagePath: imagePath ?? '',

                  );

                  viewModel.updateInventoryItem(updatedItem);
                },
                child: const Text("Update Item"),
              ),
            ],
          );
        }
      ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: Column(
        children: [
          DropDown(),
          const SizedBox(height: 10),
          
          // ElevatedButton.icon(
          //   onPressed: _addNewItem,
          //   icon: const Icon(Icons.add),
          //   label: const Text("Add New Item"),
          // ),

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
          
          Container(
            height:500,
            child: Consumer<InvenItemViewModel>(
              builder: (context, viewModel, child) {
                final items = viewModel.items;
                if (items.isEmpty) {
                  return const Center(child: Text("No items available"));
                }

                return ListView.builder(
                  padding: EdgeInsets.only(top:15),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final itemFromMap = InventoryItem.fromMap(item);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InventoryView(item: InventoryItem.fromMap(item))));
                      },
                      child: ItemCard(
                        item: itemFromMap,
                        onDelete: () async {
                          await viewModel.deleteInventoryItem(itemFromMap.id!);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
