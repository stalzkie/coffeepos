import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/inventory_item_vm.dart';

class InventoryEdit extends StatefulWidget {
  final InventoryItem item;
  const InventoryEdit({
      super.key,
      required this.item
  });

  @override
  State<InventoryEdit> createState() => _InventoryEditState();
}

class _InventoryEditState extends State<InventoryEdit> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _editFormKey = GlobalKey<FormState>();
  
  late InventoryItem _item;
  late InvenItemViewModel _item_vm;
  @override
  void initState(){
    super.initState();
    _item = widget.item;
    Future.microtask((){
      _item_vm = context.read<InvenItemViewModel>();
    });

    _quantityController.text = _item.quantity.toString();
    _priceController.text = _item.price.toString();
    _descriptionController.text = _item.description;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveItem() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final description = _descriptionController.text;

    final newItem = InventoryItem(
      id: _item.id,
      name: _item.name,
      quantity: quantity,
      price: price,
      imagePath: _item.imagePath,
      description: description,
    );

    _item_vm.updateInventoryItem(newItem);    

    setState((){
      _item.id = newItem.id;
      _item.name = newItem.name;
      _item.quantity = newItem.quantity;
      _item.price = newItem.price;
      _item.imagePath = newItem.imagePath;
      _item.description = newItem.description;
    });
    Navigator.popAndPushNamed(context, '/inventory');
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
            color: Color.fromARGB(255, 212, 212, 212),
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
                    (_item.imagePath ?? "")
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 364,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 530,
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
                  child: Form(
                    key: _editFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value){
                                  final submittedValue = value!.trim();
                                  if(submittedValue == null || submittedValue.isEmpty){
                                    return "This field can't be left empty";
                                  }
                                  if(double.tryParse(submittedValue) == null){
                                    return "Must be numeric";
                                  }
                                  if(double.parse(submittedValue) < 0){
                                    return "Must be non-negative";
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "This field can't be left empty";
                                  }
                                  if(double.tryParse(value) == null){
                                    return "Must be numeric";
                                  }
                                  if(double.parse(value) < 0){
                                    return "Must be non-negative";
                                  }
                                  return null;
                                },
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
                        const Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: (value){
                            final submittedValue = value!.trim();
                            if(submittedValue == null || submittedValue.isEmpty){
                              return "This field can't be left empty";
                            }
                            return null;
                          },
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter description",
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: (){
                                if(_editFormKey.currentState!.validate()){
                                  _saveItem();
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) 
                  
                ),
              ),
            ],
          ),
        ),
      )    
    );
  }
}