import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/inventory_item_vm.dart';
import 'inventory_item_edit.dart';

class InventoryView extends StatefulWidget{
    final InventoryItem item;
    const InventoryView({
        super.key,
        required this.item
    });

    State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView>{
  late InventoryItem _item;
  late InvenItemViewModel _item_vm;

  @override
  void initState(){
    super.initState();
    _item = widget.item;
    Future.microtask((){
      _item_vm = context.read<InvenItemViewModel>();
      _item_vm.getInventoryItemFromID(_item.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 393,
            height: 852,
            decoration: BoxDecoration(
              color: const Color(0xFFE7E7E9),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: -220,
                  child: Container(
                    width: 393,
                    height: 852,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Image.network((_item.imagePath ?? "https://www.coffeebeans.ph/storage/2023/02/arabica-1-2.jpg")!),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 364,
                  child: Container(
                    width: 393,
                    height: 550,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 285,
                                height: 36,
                                child: Text(
                                  _item.name,
                                  style: TextStyle(
                                    color: const Color(0xFF1E1E1E),
                                    fontSize: 24,
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Container(
                                width: 165,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 77,
                                      child: Text(
                                        'Quantity:',
                                        style: TextStyle(
                                          color: const Color(0x7F1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 67,
                                      child: Text(
                                        _item.quantity.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 178,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 43,
                                      child: Text(
                                        'Price:',
                                        style: TextStyle(
                                          color: const Color(0x7F1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 115,
                                      child: Text(
                                        _item.price.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 240,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Container(
                                width: double.infinity,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      child: Text(
                                        'Description',
                                        style: TextStyle(
                                          color: const Color(0x7F1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 150,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 333,
                                      height: 139,
                                      child: Text(
                                        _item.description,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.39,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 115,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF3838),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    TextButton(
                                      onPressed:(){
                                        _item_vm.deleteInventoryItem(_item.id!);
                                        Navigator.pop(context);
                                      },
                                      child:Text(
                                        'Delete',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 14,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 115,
                                height: 38,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => InventoryEdit(item: _item))
                                        );
                                      },
                                      child:Text(
                                        'Edit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 14,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}