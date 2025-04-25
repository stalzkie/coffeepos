import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:coffee_inventory_app/viewmodels/inventory_item_vm.dart';
import 'viewmodels/sale_record_vm.dart';
import 'package:provider/provider.dart';

// ViewModels - Cashier
import 'view_model/cashier/queue_view_model.dart';
import 'view_model/cashier/transaction_view_model.dart';
import 'view_model/cashier/payment_view_model.dart';

// ViewModels - Customer
import 'view_model/customer/menu_view_model.dart';
import 'view_model/customer/order_view_model.dart';

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
import 'view/admin/screens/inventory_screen.dart';

// Admin
import 'view/admin/screens/splash_screen.dart';
import 'view/admin/screens/dashboard_screen.dart';
import 'view/admin/screens/transactions.dart';
import 'view/admin/screens/users.dart';
import 'viewmodels/user_vm.dart';
import 'view/admin/screens/export_screen.dart';


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
        ChangeNotifierProvider(create: (_) => InvenItemViewModel()),
        ChangeNotifierProvider(create: (_) => SaleRecordViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel())
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
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case '/dash':
              return MaterialPageRoute(builder: (context) => const Dashboard());
            case '/cashier':
              return MaterialPageRoute(builder: (_) => const DashboardScreen());
            case '/inventory':
              return MaterialPageRoute(builder: (_) => const InventoryScreen());
            case '/transactions':
              return MaterialPageRoute(builder: (_) => const TransactionScreen());
            case '/users':
              return MaterialPageRoute(builder: (_) => const UserListScreen());
            case '/menu':
              return MaterialPageRoute(builder: (_) => const MenuScreen());
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
            case '/export':
              return MaterialPageRoute(builder: (_) => ExportScreen());
            // case '/cashier/thankYou':
            //   return MaterialPageRoute(builder: (_) => const ThankYouScreen());

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
