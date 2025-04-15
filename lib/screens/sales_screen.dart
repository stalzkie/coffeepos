import 'package:flutter/material.dart';
import '../models/sale_record.dart';
import '../models/inventory_item.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  InventoryItem? selectedItem;
  final quantityController = TextEditingController();

  void _recordSale() async {
    if (selectedItem == null || quantityController.text.isEmpty) return;
    final qty = int.tryParse(quantityController.text) ?? 0;
    final total = qty * selectedItem!.price;

    final sale = SaleRecord(
      itemName: selectedItem!.name,
      quantitySold: qty,
      totalPrice: total,
      date: DateTime.now(),
    );


    // selectedItem!.quantity -= qty;
    // await selectedItem!.save();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sale recorded and inventory updated.")));
    setState(() {
      quantityController.clear();
      selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventory = null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Record Sale"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<InventoryItem>(
              value: selectedItem,
              items: inventory
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.name),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedItem = value),
              decoration: InputDecoration(
                labelText: "Select Item",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              dropdownColor: Colors.black87,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Quantity",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _recordSale,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white12,
                  foregroundColor: Colors.white),
              child: const Text("Record Sale"),
            )
          ],
        ),
      ),
    );
  }
}
