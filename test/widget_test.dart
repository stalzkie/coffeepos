import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_inventory_app/main.dart'; // Unified main app
// If you need `SonofabeanCashierApp`, alias it here and pass the correct one

void main() {
  // --- Admin Dashboard Navigation Test ---
  testWidgets('Admin app loads and navigates between dashboard tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const SonofabeanApp());

    // Verify default screen (Dashboard) is shown
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.byIcon(Icons.insights), findsOneWidget);

    // Navigate to "Inventory"
    await tester.tap(find.byIcon(Icons.inventory_2));
    await tester.pumpAndSettle();
    expect(find.text('Inventory'), findsOneWidget);

    // Navigate to "Sales"
    await tester.tap(find.byIcon(Icons.point_of_sale));
    await tester.pumpAndSettle();
    expect(find.text('Sales'), findsOneWidget);

    // Navigate to "Export"
    await tester.tap(find.byIcon(Icons.download));
    await tester.pumpAndSettle();
    expect(find.text('Export'), findsOneWidget);
  });

  // --- Customer App Navigation Tests ---
  testWidgets('Customer app starts and shows menu screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SonofabeanApp());
    await tester.pumpAndSettle();

    expect(find.text('Menu'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('Navigation to customer order list screen works', (WidgetTester tester) async {
    await tester.pumpWidget(const SonofabeanApp());
    await tester.pumpAndSettle();

    Navigator.pushNamed(tester.element(find.byType(MaterialApp)), '/orderList');
    await tester.pumpAndSettle();

    expect(find.text('Your Order'), findsOneWidget);
  });

  // --- Basic Counter Test (e.g., Cashier UI test or Demo) ---
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SonofabeanApp());

    // Verify counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap "+" icon and check for increment
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
