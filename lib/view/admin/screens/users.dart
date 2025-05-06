import "package:flutter/material.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/drop_down.dart';
import '../../../data/models/user_model.dart';
import '../../../viewmodels/user_vm.dart';
import 'package:provider/provider.dart';
import 'user_view.dart';
import 'users_alter.dart';

class UserListScreen extends StatefulWidget{
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController search = TextEditingController();
  late List<Map<String,dynamic>> users = [];
  late UserViewModel vm;

  @override
  void initState() {
    
    super.initState();
    vm = context.read<UserViewModel>();
    Future.microtask(() async {
      vm.getUsers();
      setState(() {
        users = vm.users;
      });
    });
  }

  String formatDateCreated(DateTime date){
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  
    return '${date.day} ${months[date.month-1]}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropDown(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UsersAlter())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Add User"),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Registered Users",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(94, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children:[
                    Container(
                      width:307,
                      color: const Color.fromARGB(149, 255, 255, 255),
                      child: TextField(
                        controller: search,
                        decoration: const InputDecoration(
                          hintText: "Search transaction...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async{
                        final response = await vm.searchUsersByEmail(search.text.trim());
                        setState(() {
                          users = response;
                        });
                      },
                      child: Icon(Icons.search, size: 30,)
                    )
                  ]
                )
              ),
            ),

            
            Consumer<UserViewModel>(
  builder: (context, viewModel, child) {
    if (users.isEmpty) {
      return const Center(child: Text("No items available"));
    }

    return Column(
      children: users.map((user) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserView(
                    currentUser: UserModel.fromMap(user),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['email']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Role: ${user['role']}"),
                      Text(
                        "Date Created: ${formatDateCreated(DateTime.parse(user["created_at"]))}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  },
)
          ],
        ),
      )
    );
  }
}

