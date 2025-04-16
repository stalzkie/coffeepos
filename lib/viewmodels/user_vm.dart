import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/user_model.dart';

class UserViewModel extends ChangeNotifier{
  final _supabase = Supabase.instance.client;
  List<Map<String,dynamic>> _users = [];
  List<Map<String,dynamic>> get users => _users;

  Future<void> getUsers() async{
    try{
      _users = await _supabase.from("users").select();
      notifyListeners();
    }catch(e){
      print("$e");
    }
  }
}
