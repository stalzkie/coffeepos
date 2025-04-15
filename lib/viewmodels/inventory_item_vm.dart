import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/inventory_item.dart';

class InvenItemViewModel extends ChangeNotifier{
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> getInventoryItems() async {
    _isLoading = true;

    try{
      _items = await _supabase.from("products").select();
      notifyListeners();
    }catch (e){
      print("An error occurred while fetching Inventory Items");
    }
  }

  Future<void> addInventoryItem(InventoryItem item) async{
    try{
      await _supabase.from("products").insert(item.toMap());
      await getInventoryItems();
      print("addition success");
    }catch (e){
      print("An error occurred while trying to add an entry");
      print(e);
    }
  }

  Future<void> updateInventoryItem(InventoryItem item) async{
    try{
      await _supabase.from("products").update(item.toMap()).eq("id", item.id!);
      await getInventoryItems();
    }catch(e){
      print("error trying to update inventory item");
    }
  }
  
  Future<void> deleteInventoryItem(int id) async {
    try{
      await _supabase.from("products").delete().eq("id", id);
      await getInventoryItems();
    }catch(e){
      print("There was an error deleting an inventory item:$e");
    }
  }
}