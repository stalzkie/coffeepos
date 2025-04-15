import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sale_record.dart';

class SaleRecordViewModel extends ChangeNotifier{
  final _supabase = Supabase.instance.client;
  double _todayTotal = 0;
  double _allTimeTotal = 0;
  String _popular = '';
  int _popularAmount = 0;
  String _notPopular = '';
  int _notPopularAmount = 0;
  bool _isLoading = false;

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;
  double get todayTotal => _todayTotal;
  double get allTimeTotal => _allTimeTotal;
  String get popular => _popular;
  String get notPopular => _notPopular;
  String get popularAmount => _popularAmount.toString();
  String get notPopularArmount => _notPopularAmount.toString();


  SaleRecordViewModel(){
    getTodayTotal();
    getAllTimeTotal();
    getMostPopularProduct();
    getLeastPopularProduct();
    getWeeklySales();
  }

  final Map<String, double> _weeklySales = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'Sun': 0,
  };

  Map<String, double> get weeklySales => _weeklySales;

  Future<void> getWeeklySales() async {
    try{
      final response = await _supabase.rpc("get_weekly_sales");
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      
      if(response!=null){
        for(int i = 0; i < 7; i++){
        _weeklySales[days[i]] = response[i]['sales_count'].toDouble();
        }
        notifyListeners();
      }
    }catch(e){
      print("trouble with getting weekly sales:$e");
    }
  }

  Future<void> getTodayTotal() async {
    try {
      // Use the range to count records created between the start and end of today
      final response = await _supabase.rpc("get_today_sales");
      if(response!=null){
        _todayTotal = response.toDouble();
      }
      notifyListeners();
    } catch (e) {
      print("Error with getting today's total: $e");
    }
  }

  Future<void> getAllTimeTotal() async{
    try{
      final response = await _supabase.rpc('get_total_sales');
      if(response!=null){
        _allTimeTotal = response.toDouble();
      }
      notifyListeners();
    }catch(e){
      print("error with getting all time total:$e");
    }
  }

  Future<void> getMostPopularProduct() async{
    try{
      print("test1");
      final response = await _supabase.rpc("get_most_frequent_item");
      print("test2");

      print(response);
      _popular = response[0]['name'];
      _popularAmount = response[0]['total_quantity'];
      // _popular = response;
    }catch(e){
      print("error with getting most popular product:$e");
    }
  }

  Future<void> getLeastPopularProduct() async{
    try{
      print(3);
      final response = await _supabase.rpc("get_least_frequent_item");
      print(4);
      print(response);
      _notPopular = response[0]['name'];
      _notPopularAmount = response[0]['total_quantity'];
      // _popular =;
    }catch(e){
      print("error with getting least popular product:$e");
    }
  }
  
  Future<void> getSalesOrders() async {
    _isLoading = true;
    notifyListeners();

    try{
      _orders = await _supabase.from("SalesRecords");
      notifyListeners();
    }catch (e){
      print("error trying to fetch data");
    }

    _isLoading = false;
  }
}

