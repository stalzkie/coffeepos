import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/customer/menu_view_model.dart';
import '../../../data/models/product_model.dart';
import '../widgets/product_card.dart';
import 'add_order_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Stack(
        children: [
          // Header with status bar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: const Center(
                child: Text(
                  'sonofabean.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi there,',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      Text(
                        'sonofabean!',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Buttons Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/orderList'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(170),
                            side: const BorderSide(width: 2, color: Colors.black),
                          ),
                        ),
                        child: const Text(
                          'Your Order',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16.49,
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    onChanged: viewModel.updateSearchQuery,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search coffee...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF525252),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Product list
                if (viewModel.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: viewModel.filteredProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8), // 👈 spacing adjusted
                      itemBuilder: (context, index) {
                        final product = viewModel.filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddOrderScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
