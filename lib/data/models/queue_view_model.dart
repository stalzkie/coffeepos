import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/cashier_transaction_model.dart';
import '../repositories/transaction_repository.dart';

class QueueViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

Future<void> fetchTransactions() async {
  _transactions = await TransactionRepository().fetchAllTransactions(); // ✅
  notifyListeners();
}

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<TransactionModel> get filteredTransactions {
    if (_searchQuery.isEmpty) return _transactions;
    return _transactions
        .where((tx) =>
            tx.id.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
}
