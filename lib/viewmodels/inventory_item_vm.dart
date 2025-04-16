import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/inventory_item.dart';

class InvenItemViewModel extends ChangeNotifier{
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  InventoryItem? _selectedProduct;

  List<Map<String, dynamic>> get items => _items;
  bool get isLoading => _isLoading;
  InventoryItem? get selectedProduct => _selectedProduct;
  

  Future<void> getInventoryItems() async {
    _isLoading = true;

    try{
      _items = await _supabase.from("products").select();
      notifyListeners();
    }catch (e){
      print("An error occurred while fetching Inventory Items$e\n");
    }
  }

  Future<void> addInventoryItem(InventoryItem item) async{
    try{
      await _supabase.from("products").insert(item.noDateMap());
      await getInventoryItems();
      print("addition success");
    }catch (e){
      print("An error occurred while trying to add an entry$e\n");
      print(e);
    }
  }

  Future<void> updateInventoryItem(InventoryItem item) async{
    try{
      await _supabase.from("products").update(item.noDateMap()).eq("id", item.id!);
      await getInventoryItems();
    }catch(e){
      print("error trying to update inventory item$e\n");
    }
  }
  
  Future<void> deleteInventoryItem(int id) async {
    try{
      await _supabase.from("products").delete().eq("id", id);
      await getInventoryItems();
    }catch(e){
      print("There was an error deleting an inventory item:$e\n");
    }
  }

  Future<void> getInventoryItemFromID(int id) async{
    try{
      final response = await _supabase.from("products").select().eq("id", id).single();
      _selectedProduct = InventoryItem.fromMap(response);
      notifyListeners();
    }catch(e){
      print("There was an fetching inventory item:$e\n");
    }
  }
}