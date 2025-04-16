import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ Supabase import

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showMoreActions = false;

  Future<Map<String, dynamic>?> _fetchLowestQuantityProduct() async {
    final response = await Supabase.instance.client
        .from('products')
        .select('description, quantity')
        .order('quantity', ascending: true)
        .limit(1)
        .single();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E9),
      body: Column(
        children: [
          // 🟤 Header
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showMoreActions ? 130 : 99,
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'sonofabean.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    setState(() {
                      showMoreActions = !showMoreActions;
                    });
                  },
                  child: const Text(
                    'More Actions',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Figtree',
                    ),
                  ),
                ),
                if (showMoreActions)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF6666),
                          borderRadius: BorderRadius.circular(121.61),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 14,
                              fontFamily: 'Figtree',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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

          // Navigation buttons + alert widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                FutureBuilder<Map<String, dynamic>?>( // I feel like this should be in a model, but WTH
                  future: _fetchLowestQuantityProduct(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const SizedBox.shrink();
                    }

                    final data = snapshot.data!;
                    final quantity = data['quantity'] as int?;

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Inventory Status',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Figtree',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (quantity != null && quantity < 10)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red[700],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LOW INVENTORY',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                      fontFamily: 'Figtree',
                                    ),
                                  ),
                                  Text(
                                    data['description'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Figtree',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Quantity: ${quantity.toString()}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                      fontFamily: 'Figtree',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            const Text(
                              'No Inventory Alerts',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: 'Figtree',
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                _navButton(context, 'Customer Order Queue', '/queue'),
                const SizedBox(height: 20),
                _navButton(context, 'Customer View', '/menu'),
              ],
            ),
          ),
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
}
