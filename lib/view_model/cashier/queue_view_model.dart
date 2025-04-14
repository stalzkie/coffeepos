import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/cashier_transaction_model.dart';

class QueueViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> fetchTransactions() async {
    final response = await _client
        .from('transactions')
        .select()
        .order('created_at', ascending: false);

    _transactions = (response as List)
        .map((data) => TransactionModel.fromJson(data))
        .toList();

    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<TransactionModel> get filteredTransactions {
    return _transactions.where((tx) {
      final matchesQuery = tx.id.contains(_searchQuery);
      final isPending = tx.status.toLowerCase() == 'pending';
      return matchesQuery && isPending;
    }).toList();
  }

}
