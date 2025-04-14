import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        children: [
          // 🟤 Header
          Container(
            height: 99,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'sonofabean.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Greeting
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hi there,\n',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 24,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w700,
                        height: 1.67,
                      ),
                    ),
                    TextSpan(
                      text: 'sonofabean staff!',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 40,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                _navButton(context, 'Customer Order Queue', '/queue'),
                const SizedBox(height: 20),
                _navButton(context, 'Low Inventory Alert (Placeholder)', null),
                const SizedBox(height: 20),
                _navButton(context, 'Customer View', '/menu'),
                const SizedBox(height: 30),
                _signOutButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String? route) {
    return GestureDetector(
      onTap: route != null ? () => Navigator.pushNamed(context, route) : null,
      child: Container(
        width: double.infinity,
        height: 83,
        padding: const EdgeInsets.symmetric(horizontal: 17.04, vertical: 8.52),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 20,
            fontFamily: 'Figtree',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return Container(
      width: 165,
      height: 27,
      decoration: BoxDecoration(
        color: const Color(0xFFEF6666),
        borderRadius: BorderRadius.circular(121.61),
      ),
      child: const Center(
        child: Text(
          'Sign Out',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 17.03,
            fontFamily: 'Figtree',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}