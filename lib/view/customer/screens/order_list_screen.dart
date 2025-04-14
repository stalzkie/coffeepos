import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/customer/order_view_model.dart';
import 'edit_order_screen.dart';
import 'package:sonofabean_combined/view/customer/screens/choose_payment_screen.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrderViewModel>(context);
    final summary = viewModel.orderItemSummaryList;
    final totalPrice = viewModel.orderItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔲 Header
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

          // 📝 Title
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 30),
            child: Text(
              'Your Order',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Figtree',
                color: Color.fromARGB(255, 88, 88, 88),
              ),
            ),
          ),

          // 💰 Total Price
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10, top: 2),
            child: Text(
              'Total Price: ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Figtree',
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ),

          // 📦 Product List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: viewModel.orderItems.isEmpty
                  ? const Center(child: Text("You haven't ordered anything!"))
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: viewModel.orderItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = viewModel.orderItems[index];
                        final imageUrl = item.product.imageUrl.startsWith('http')
                            ? item.product.imageUrl
                            : 'https://uolinrriyhezsqzefkpi.supabase.co/storage/v1/object/public/product-images/${item.product.imageUrl}';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditOrderScreen(
                                  product: item.product,
                                  initialQuantity: item.quantity,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 361,
                            height: 131,
                            padding: const EdgeInsets.all(20),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(width: 2, color: Colors.black),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(85.32),
                                  child: Image.network(
                                    imageUrl,
                                    width: 93,
                                    height: 93,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 93,
                                      height: 93,
                                      color: const Color(0xFFCCCCCC),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Figtree',
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'PHP${item.product.price.toStringAsFixed(2)} · ${item.quantity} pcs',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Figtree',
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.product.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Figtree',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => viewModel.removeFromOrder(item.product),
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // ✅ Footer Buttons
          Container(
            height: 94,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E1E1E),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1.3),
                      borderRadius: BorderRadius.circular(170),
                    ),
                  ),
                  child: const Text(
                    'Back to Menu',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.4,
                      height: 2.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Access orderItems from OrderViewModel
                    final orderItems = Provider.of<OrderViewModel>(context, listen: false).orderItems;

                    // Pass both totalPrice and orderItems to ChoosePaymentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChoosePaymentScreen(
                          totalPrice: totalPrice,
                          orderItems: orderItems,  // Pass orderItems here
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E1E1E),
                    backgroundColor: const Color(0xFF62FF6D),
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1.3),
                      borderRadius: BorderRadius.circular(170),
                    ),
                  ),
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.4,
                      height: 2.5,
                    ),
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
