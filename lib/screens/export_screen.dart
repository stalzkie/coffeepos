import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/inventory_item.dart';
import '../models/sale_record.dart';
import '../viewmodels/inventory_item_vm.dart';
import '../viewmodels/sale_record_vm.dart';
import 'package:provider/provider.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _MyExportScreenState();
}

class _MyExportScreenState extends State<ExportScreen>{
  late InvenItemViewModel inventory_vm;
  late SaleRecordViewModel sales_vm;

  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      inventory_vm = Provider.of<InvenItemViewModel>(context, listen: false);
      sales_vm = Provider.of<SaleRecordViewModel>(context, listen:false);

      inventory_vm.getInventoryItems();
      sales_vm.getSalesOrders();
    });
  }

  Future<void> exportInventory(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['Name', 'Description', 'Price', 'Quantity', 'Image Path']
    ];
    
    for(var items in inventory_vm.items){
      rows.add([
        items['name'],
        items['description'],
        items['price'],
        items['quantity'],
        items['imagePath']
      ]);
    }

    await saveCSV(rows, 'inventory_export.csv', context);
  }

  Future<void> exportSales(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['Item Name', 'Quantity Sold', 'Total Price', 'Date']
    ];

    for(var sales in sales_vm.orders){
      rows.add([
        sales['itemNAme'],
        sales['quantitySold'],
        sales['totalPrice'],
      ]);
    }

    await saveCSV(rows, 'sales_export.csv', context);
  }

  Future<void> saveCSV(List<List<dynamic>> data, String filename, BuildContext context) async {
    final csvData = const ListToCsvConverter().convert(data);
    final directory = await getExternalStorageDirectory();
    print(directory);
    final path = '${directory!.path}/$filename';
    final file = File(path);
    await file.writeAsString(csvData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exported to $filename')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Export Data'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _glassButton(
              text: 'Export Inventory CSV',
              onPressed: () => exportInventory(context),
            ),
            const SizedBox(height: 20),
            _glassButton(
              text: 'Export Sales CSV',
              onPressed: () => exportSales(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassButton({required String text, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
