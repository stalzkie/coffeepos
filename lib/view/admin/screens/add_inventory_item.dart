import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/inventory_item_vm.dart';

class InventoryAdd extends StatefulWidget{
    const InventoryAdd({
        super.key,
    });

    State<InventoryAdd> createState() => _InventoryAddState();
}

class _InventoryAddState extends State<InventoryAdd>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 393,
            height: 890,
            decoration: BoxDecoration(
              color: const Color(0xFFE7E7E9),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: -250,
                  child: Container(
                    width: 393,
                    height: 852,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Image.network("https://withsaltandwit.com/wp-content/uploads/2014/03/Perfect-Homemade-Iced-Coffee-Cold-Brew-2.jpg"),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 364,
                  child: Container(
                    width: 393,
                    height: 520,
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
                            spacing: 10,
                            children: [
                              Container(
                                width: 280,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Enter name...',
                                  style: TextStyle(
                                    color: const Color(0x7F1E1E1E),
                                    fontSize: 24,
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                  width: 36,
                                  height: 36,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                        color: Colors.black.withValues(alpha: 128),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        child: Text("<", style: TextStyle(fontSize: 16)),
                                      ),
                                    ],
                                  ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 70,
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
                                    Container(
                                      width: 85,
                                      height: 34,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          SizedBox(
                                            width: 76,
                                            height: 19,
                                            child: Text(
                                              'Enter...',
                                              style: TextStyle(
                                                color: const Color(0x7F1E1E1E),
                                                fontSize: 10,
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
                                width: 178,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Container(
                                      width: 125,
                                      height: 34,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          SizedBox(
                                            width: 111,
                                            height: 19,
                                            child: Text(
                                              'Enter...',
                                              style: TextStyle(
                                                color: const Color(0x7F1E1E1E),
                                                fontSize: 10,
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
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    SizedBox(
                                      width: 330,
                                      height: 200,
                                      child: Text(
                                        'Enter...',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
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
                          decoration: BoxDecoration(
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 115,
                                height: 38,
                                padding: const EdgeInsets.all(10),
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
                                    Text(
                                      'Cancel',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF1E1E1E),
                                        fontSize: 14,
                                        fontFamily: 'Figtree',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 114.03,
                                height: 37.68,
                                padding: const EdgeInsets.all(9.92),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF62FF6D),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.98,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                    borderRadius: BorderRadius.circular(29.75),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 9.92,
                                  children: [
                                    Text(
                                      'Save',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF1E1E1E),
                                        fontSize: 13.88,
                                        fontFamily: 'Figtree',
                                        fontWeight: FontWeight.w500,
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