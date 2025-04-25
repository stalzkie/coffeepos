import 'package:coffee_inventory_app/viewmodels/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user_model.dart';
import 'users_alter.dart';

class UserView extends StatefulWidget{
  final UserModel currentUser;
  const UserView({super.key, required this.currentUser});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView>{
  late UserModel _currentUser;
  late UserViewModel _userVM;
  @override
  void initState(){
    super.initState();
    _currentUser = widget.currentUser;
    _userVM = context.read<UserViewModel>();
  }
  @override
  Widget build(BuildContext context){
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
                  spacing: 15,
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
                    Text(
                      _currentUser.full_name,
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    Text(
                      "Role",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      _currentUser.role,
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      _currentUser.email,
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    Text(
                      "Contact No.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      _currentUser.contact_no,
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:100,
                          child: TextButton(
                            onPressed: (){
                              // delete
                              _userVM.deleteUserById(_currentUser.id);
                              Navigator.popAndPushNamed(context, "/users");
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black, width: 1),
                              backgroundColor: Colors.red,
                            ),
                            
                            child: Text("Delete", style: TextStyle(color:Colors.white))
                          )
                        ),
                        SizedBox(width: 30,),
                        SizedBox(
                          width:100,
                          child: TextButton(
                            onPressed: (){
                              //navigate to user edit
                              Navigator.push(context,
                              MaterialPageRoute(builder: (_) => UsersAlter(currentUser: _currentUser,)));
                            },
                            style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black, width: 1),
                              backgroundColor: Colors.green[400],
                            ),
                            
                            child: Text("Edit", style: TextStyle(color:Colors.white))
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