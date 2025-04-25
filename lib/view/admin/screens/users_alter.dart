import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../viewmodels/user_vm.dart';


class UsersAlter extends StatefulWidget{
  final UserModel? currentUser;

  const UsersAlter({super.key, this.currentUser});

  @override
  State<UsersAlter> createState() => _UsersAlterState();
}

class _UsersAlterState extends State<UsersAlter>{
  String? role;
  UserModel? _currentUser;
  final _formKey = GlobalKey<FormState>();
  final _supabase = Supabase.instance.client;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  late UserViewModel _userVM;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _currentUser = widget.currentUser;
    _userVM = context.read<UserViewModel>();
  }

  void _userSignUp() async{
    try{
      String userEmail = _emailController.text;
      String fullName = _nameController.text;
      final AuthResponse response = await _supabase.auth.signUp(
        email: userEmail,
        password: _generatePassword(fullName)
      );
      Map<String, dynamic> userData = {
        'id' : response.user?.id,
        'email': userEmail,
        'role': role,
        'full_name' : fullName,
        'contact_no' : _contactController.text
      };
      await _userVM.InsertUser(userData);

      Navigator.popAndPushNamed(context, '/users');
    }on AuthException catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16), // spacing from edges
        ),
      );
    }catch(e){
      print(e);
    }
    
  }

  String _generatePassword(String name){
    String password = '';
    List<String> splitString = name.split(" ");
    DateTime now = DateTime.now();

    for(String word in splitString){
      password+=word[0];
    }

    password+=now.year.toString();
    return password;
  }

  void _userUpdate() async {
    print("${_currentUser!.id}, ${_emailController.text}");
    final response = await _supabase.functions.invoke('update_auth_user', body: {'user_id': _currentUser!.id, 'email' : _emailController.text});
    if (response.status >= 400) {
      print('Error: ${jsonDecode(response.data)}');
    } else {
      print('Success: ${jsonDecode(response.data)}');
      Map<String, dynamic> userData = {
        'id': _currentUser!.id,
        'full_name' : _nameController.text,
        'email' : _emailController.text,
        'role' : role,
        'contact_no' : _contactController.text,
        'created_at' : _currentUser!.created_at
      };
      await _userVM.updateUser(userData);
    }
  }

  void _handleGreenEvent(){
    if(_currentUser != null){
      //update
      _userUpdate();

    }else{
      _userSignUp();
    }
  }

  @override 
  Widget build(BuildContext context){
    if(_currentUser != null){
      _contactController.text = _currentUser!.contact_no;
      _nameController.text = _currentUser!.full_name;
      _emailController.text = _currentUser!.email;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 231, 231, 233),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top:Radius.circular(50))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.account_circle_outlined,
                              size: 120,
                            ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child:IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                          )
                        ),
                      ],
                    ),
                    Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(
                      height:40,
                      width: 330,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left:5),
                          border: OutlineInputBorder(),
                        )
                      )
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(
                      height:40,
                      width: 330,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left:5),
                          border: OutlineInputBorder(),
                        )
                      )
                    ),
                    Text(
                      "Role",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    DropdownButton<String>(
                      // focusColor: Colors.black,
                      // dropdownColor: const Color.fromARGB(255, 20, 20, 20),
                      value: role,
                      hint: Text('Select role'),
                      onChanged: (value) {
                        setState(() {
                          role = value!;
                        });
                      },
                      items: ['Admin', 'Cashier']
                          .map((role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                    ),
                    Text(
                      "Contact No.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(
                      height:40,
                      width: 330,
                      child: TextFormField(
                        controller: _contactController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left:5),
                          border: OutlineInputBorder(),
                        )
                      )
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:100,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black, width: 1),
                              backgroundColor: Colors.red,
                            ),
                            
                            child: Text("Cancel", style: TextStyle(color:Colors.white))
                          )
                        ),
                        SizedBox(width: 30,),
                        SizedBox(
                          width:100,
                          child: TextButton(
                            onPressed: _handleGreenEvent,
                            style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black, width: 1),
                              backgroundColor: Colors.green[400],
                            ),
                            
                            child: Text("Save", style: TextStyle(color:Colors.white))
                          )
                        ),
                      ],
                    )
                  ],
                )
              )
            )
          )
        ],
      ),
    );
  }
}