import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/inventory_item_vm.dart';

class InventoryAdd extends StatefulWidget {
  const InventoryAdd({super.key});

  @override
  State<InventoryAdd> createState() => _InventoryAddState();
}

class _InventoryAddState extends State<InventoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveItem() {
    final name = _nameController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final description = _descriptionController.text;

    final newItem = InventoryItem(
      name: name,
      quantity: quantity,
      price: price,
      description: description,
    );

    context.read<InvenItemViewModel>().addInventoryItem(newItem);
    
    Navigator.pop(context);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 41, 41, 73),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: -250,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 852,
                  child: Image.network(
                    "https://withsaltandwit.com/wp-content/uploads/2014/03/Perfect-Homemade-Iced-Coffee-Cold-Brew-2.jpg",
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 364,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 520,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Back button
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Item Name",
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Quantity and Price
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Quantity",
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Price",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter description",
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _cancel,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _saveItem,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}