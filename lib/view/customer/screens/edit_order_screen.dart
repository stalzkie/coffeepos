import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/product_model.dart';
import '../../../view_model/customer/order_view_model.dart';

class EditOrderScreen extends StatefulWidget {
  final Product product;
  final int initialQuantity;

  const EditOrderScreen({
    super.key,
    required this.product,
    required this.initialQuantity,
  });

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context);
    final imageUrl = widget.product.imageUrl.startsWith('http')
        ? widget.product.imageUrl
        : 'https://uolinrriyhezsqzefkpi.supabase.co/storage/v1/object/public/product-images/${widget.product.imageUrl}';

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Stack(
        children: [
          // 🖼 Background image with blur
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.black.withOpacity(0.1)),
                ),
              ],
            ),
          ),

          // 🟤 Top header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 99,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                    fontSize: 14,
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // 🧾 White content container
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔙 Product name + Back button
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Figtree',
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 💸 Price row
                  Row(
                    children: [
                      const Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0x7F1E1E1E),
                          fontFamily: 'Figtree',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PHP${widget.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E1E1E),
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 📝 Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0x7F1E1E1E),
                      fontFamily: 'Figtree',
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Figtree',
                          letterSpacing: 0.39,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔢 Quantity controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _quantityButton('-', () {
                        if (quantity > 1) {
                          setState(() => quantity--);
                        }
                      }, const Color(0xFFFF3838)),
                      const SizedBox(width: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                        child: Text(
                          '$quantity',
                          key: ValueKey<int>(quantity),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Figtree',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      _quantityButton('+', () {
                        setState(() => quantity++);
                      }, const Color(0xFF62FF6D)),
                    ],
                  ),

                  const Spacer(),

                  // 🟨 Save updated quantity
                  GestureDetector(
                    onTap: () {
                      orderVM.updateQuantity(widget.product, quantity);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Update Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(String label, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'Figtree',
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}
