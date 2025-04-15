import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ViewModels - Cashier
import 'view_model/cashier/queue_view_model.dart';
import 'view_model/cashier/transaction_view_model.dart';
import 'view_model/cashier/payment_view_model.dart';

// ViewModels - Customer
import 'view_model/customer/menu_view_model.dart';
import 'view_model/customer/order_view_model.dart';
import 'view_model/customer/payment_view_model.dart';

// Screens - Customer
import 'view/customer/screens/menu_screen.dart';
import 'view/customer/screens/order_list_screen.dart';
import 'view/customer/screens/choose_payment_screen.dart';
import 'view/customer/screens/qr_code_screen.dart';
import 'view/customer/screens/thank_you_screen.dart';

// Screens - Cashier
import 'view/cashier/screens/dashboard_screen.dart';
import 'view/cashier/screens/queue_screen.dart';
import 'view/cashier/screens/confirm_payment_screen.dart';
import 'view/cashier/screens/transaction_detail_screen.dart';
import 'view/cashier/screens/cashier_thank_you_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tepdcxtlykiugezsaamc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlcGRjeHRseWtpdWdlenNhYW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2MzkyNDksImV4cCI6MjA1OTIxNTI0OX0.Is6nErcbr-D68NS8qZZUKCeJw4AkyJ0iWc-ODUFw5nk',
  );

  runApp(const SonofabeanApp());
}

class SonofabeanApp extends StatelessWidget {
  const SonofabeanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cashier
        ChangeNotifierProvider(create: (_) => QueueViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
        // Customer
        ChangeNotifierProvider(create: (_) => MenuViewModel()..fetchProducts()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => CustomerPaymentViewModel()),
      ],
      child: MaterialApp(
        title: 'Sonofabean Coffee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: const Color(0xFFE7E7E9),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            // Cashier routes
            case '/':
              return MaterialPageRoute(builder: (_) => const DashboardScreen());

            case '/queue':
              return MaterialPageRoute(builder: (_) => const QueueScreen());

            case '/cashier/confirmPayment':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => ConfirmPaymentScreen(
                  transactionId: args['transactionId'],
                  totalPrice: args['totalPrice'],
                ),
              );

            case '/cashier/thankYou':
              return MaterialPageRoute(builder: (_) => const ThankYouScreen());

            // Customer routes
            case '/menu':
              return MaterialPageRoute(builder: (_) => const MenuScreen());

            case '/orderList':
              return MaterialPageRoute(builder: (_) => const OrderListScreen());

            case '/choosePayment':
              return MaterialPageRoute(builder: (_) => const ChoosePaymentScreen());

            case '/qrCode':
              return MaterialPageRoute(builder: (_) => const QrCodeScreen());

            case '/thankYou':
              return MaterialPageRoute(builder: (_) => const CustomerThankYouScreen());

            // Fallback route
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
