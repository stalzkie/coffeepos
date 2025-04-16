import "package:flutter/material.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/drop_down.dart';
import '../../../data/models/user_model.dart';
import '../../../viewmodels/user_vm.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget{
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _supabase = Supabase.instance.client;
  late List<Map<String,dynamic>> users = [];

  @override
  void initState() {
    
    super.initState();
    Future.microtask(() async {
      final vm = context.read<UserViewModel>();
      vm.getUsers();
      setState(() {
        users = vm.users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            DropDown(),

            // Add User Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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

            // Registered Users Title
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

            // User Cards
            Consumer<UserViewModel>(
              builder: (context, viewModel, child){
                final users = viewModel.users;
                if (users.isEmpty) {
                  return const Center(child: Text("No items available"));
                }
                return Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user['email']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Role: admin"),
                                  Text("Date Created: ${DateTime.parse(user["created_at"])}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

