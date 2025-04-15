import 'package:flutter/material.dart';

void main() {
  runApp(const CustomerScreen());
}

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIP Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WIPScreen(),
    );
  }
}

class WIPScreen extends StatelessWidget {
  const WIPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIP Screen'),
      ),
      body: const Center(
        child: Text(
          'WIP lest I lose sanity',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
