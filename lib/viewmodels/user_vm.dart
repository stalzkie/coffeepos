import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/user_model.dart';

class UserViewModel extends ChangeNotifier{
  final _supabase = Supabase.instance.client;
  List<Map<String,dynamic>> _users = [];
  List<Map<String,dynamic>> get users => _users;

  Future<void> getUsers() async{
    try{
      _users = await _supabase.from("profiles").select();
      notifyListeners();
    }catch(e){
      print("$e");
    }
  }

  Future<void> InsertUser(Map<String, dynamic> userData) async{
    try{
      await _supabase.from('profiles').insert(userData);
    }catch(e){
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getUserFromID(String uuid) async {
    try{
      return await _supabase.from('profiles').select().eq('id', uuid).single();
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<void> updateUser(Map<String, dynamic> userData) async {
    try{
      await _supabase.from('profiles')
        .update(userData)
        .eq('id', userData['id']);
      getUsers();
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<void> deleteUserById(String uuid) async {
    final res = await _supabase.functions.invoke('delete_auth_user', body: {'user_id': uuid});
    
    if(res.status == 200){
      print("delete success: ${res.data}");
    }else{
      print("delete failed: ${res.data}");
    }
  }

  Future<List<Map<String, dynamic>>> searchUsersByEmail(String email) async {
    try{
      final response = await _supabase.from("profiles")
        .select()
        .ilike('email', '%$email%');

      return response;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<String> getUserTypeByID(String UUID) async {
    try{
      final response = await _supabase.from('profiles')
                      .select('role').eq('id', UUID).single();
      return response['role'];
    }catch(e){
      print("erroe with getting user type by id: $e");
      return "";
    }
  }
}
