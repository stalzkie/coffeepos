import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonofabean_combined/view/cashier/screens/thank_you_screen.dart';
import 'package:sonofabean_combined/view/customer/screens/choose_payment_screen.dart';
import 'package:sonofabean_combined/view/customer/screens/order_list_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Cashier imports
import 'view/cashier/screens/queue_screen.dart';
import 'view/cashier/screens/confirm_payment_screen.dart';
import 'view/cashier/screens/dashboard_screen.dart';
import 'view_model/cashier/queue_view_model.dart';
import 'view_model/cashier/transaction_view_model.dart';
import 'view_model/cashier/payment_view_model.dart'; // Cashier's

// Customer imports
import 'view/customer/screens/qr_code_screen.dart';
import 'view/customer/screens/menu_screen.dart';
import 'view_model/customer/menu_view_model.dart';
import 'view_model/customer/order_view_model.dart';
import 'view_model/customer/payment_view_model.dart' as customer; // ✅ Add alias here


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tepdcxtlykiugezsaamc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlcGRjeHRseWtpdWdlenNhYW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2MzkyNDksImV4cCI6MjA1OTIxNTI0OX0.Is6nErcbr-D68NS8qZZUKCeJw4AkyJ0iWc-ODUFw5nk',
  );

  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cashier providers
        ChangeNotifierProvider(create: (_) => QueueViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),

        // Customer providers
        ChangeNotifierProvider(create: (_) => customer.PaymentViewModel()), // ✅ Added customer payment VM
        ChangeNotifierProvider(create: (_) => MenuViewModel()..fetchProducts()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const DashboardScreen());
            case '/menu':
              return MaterialPageRoute(builder: (_) => const MenuScreen());
            case '/queue':
              return MaterialPageRoute(builder: (_) => const QueueScreen());
            case '/cashier/confirmPayment':
              final totalPrice = settings.arguments as double;
              return MaterialPageRoute(
                builder: (_) => ConfirmPaymentScreen(totalPrice: totalPrice),
              );
            case '/thankYou':
              return MaterialPageRoute(builder: (_) => const ThankYouScreen());
            case '/orderList':
              return MaterialPageRoute(builder: (_) => const OrderListScreen());
            case '/qrCode':
              return MaterialPageRoute(builder: (_) => const QrCodeScreen());
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ),
              );
          }
        },
      ),
    );
  }
}
