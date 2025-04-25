import 'dart:io';
import 'package:coffee_inventory_app/data/models/cashier_transaction_model.dart';
import 'package:coffee_inventory_app/data/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/models/inventory_item.dart';
import '../../../data/models/sale_record.dart';
import '../../../viewmodels/inventory_item_vm.dart';
import '../../../viewmodels/sale_record_vm.dart';
import 'package:provider/provider.dart';
import '../widgets/drop_down.dart';
import '../widgets/export_button.dart';

class ButtonData{
  final String text;
  bool isActivated;

  ButtonData({required this.text, this.isActivated = false});
}

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _MyExportScreenState();
}

class _MyExportScreenState extends State<ExportScreen>{
  late InvenItemViewModel inventory_vm;
  late SaleRecordViewModel sales_vm;
  late TransactionRepository transactionRepository;
  late List<TransactionModel> transactions;
  int _activeButton = -1;

  List<ButtonData> buttonData = [
    ButtonData(text:"Transaction History"),
    ButtonData(text:"Inventory List"),
    ButtonData(text:"Sales Records")
  ];

  @override
  void initState(){
    super.initState();
    Future.microtask(() async{
      inventory_vm = context.read<InvenItemViewModel>();
      sales_vm = context.read<SaleRecordViewModel>();
      transactionRepository = TransactionRepository();

      inventory_vm.getInventoryItems();
      sales_vm.getSalesOrders();
      transactions = await transactionRepository.fetchTransactionsNoFilter();
    });
  }

  Future<void> exportTransactions(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['id','total_price','payment_method','status','created_at']
    ];

    for(var transaction in transactions){
      rows.add([
        transaction.id,
        transaction.totalPrice,
        transaction.paymentMethod,
        transaction.status,
        transaction.createdAt
      ]);
    }
    
    await saveCSV(rows, 'transactions_export.csv', context);
  }

  Future<void> exportInventory(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['Name', 'Description', 'Price', 'Quantity', 'Image Path', 'Created At']
    ];
    
    for(var items in inventory_vm.items){
      rows.add([
        items['name'],
        items['description'],
        items['price'],
        items['quantity'],
        items['image_url'],
        items['created_at']
      ]);
    }

    await saveCSV(rows, 'inventory_export.csv', context);
  }

  Future<void> exportSales(BuildContext context) async {
    List<List<dynamic>> rows = [
      ['id','transaction_id','product_id','quantity','price','created_at','name','description']
    ];

    for(var sales in sales_vm.orders){
      rows.add([
        sales['id'],
        sales['transaction_id'],
        sales['product_id'],
        sales['quantity'],
        sales['price'],
        sales['transactions']['created_at'],
        sales['products']['name'],
        sales['products']['description'],
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

  void buttonSetActive(int buttonIndex){
    setState((){
      for(int i = 0; i < buttonData.length; i++){
        buttonData[i].isActivated = (i != buttonIndex);  
      }
      _activeButton = buttonIndex;
    });
  }

  void _exportData(){
    switch(_activeButton){
      case 0:
        exportTransactions(context);
        break;
      case 1:
        exportInventory(context);
        break;
      case 2:
        exportSales(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropDown(),
          SizedBox(height:15),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left:15),
                child: Text(
                  "Export\nYour Files",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )
                ),
              )
            ],
          ),
          SizedBox(height:15),
          Column(
            children: List.generate(
              buttonData.length, (index){
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        buttonSetActive(index);
                      },
                      child: ExportButton(
                        text: buttonData[index].text,
                        isActivated: buttonData[index].isActivated,
                      )
                    ),
                    SizedBox(height:15)
                  ]
                );
              }
            )
          ),
          SizedBox(height:30),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero
            ),
            onPressed: _exportData,
            child:Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 122, 237, 126),
                border: Border.all(width:1, color: Colors.black),
                borderRadius: BorderRadius.circular(10)
              ),
              child: SizedBox(
                height: 42,
                width:200,
                child: Center(child:Text("Export", style: TextStyle(color: Colors.black, fontSize: 16)))
              )
            )
          ),
        ],
      ),

    );
  }
}
