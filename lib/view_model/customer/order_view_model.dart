import 'package:flutter/material.dart';
import '../../../data/models/order_item_model.dart';
import '../../../data/models/product_model.dart';

class OrderViewModel extends ChangeNotifier {
  final List<OrderItem> _orderItems = [];

  List<OrderItem> get orderItems => List.unmodifiable(_orderItems);

  
  void addToOrder(Product product) {
    final index = _orderItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _orderItems[index] = OrderItem(
        product: product,
        quantity: _orderItems[index].quantity + 1,
      );
    } else {
      _orderItems.add(OrderItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

 
  void updateQuantity(Product product, int newQty) {
    final index = _orderItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (newQty <= 0) {
        _orderItems.removeAt(index);
      } else {
        _orderItems[index] = OrderItem(product: product, quantity: newQty);
      }
      notifyListeners();
    }
  }

  
  void removeFromOrder(Product product) {
    _orderItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

 
  double get totalAmount =>
      _orderItems.fold(0, (sum, item) => sum + item.totalPrice);


  void clearOrder() {
    _orderItems.clear();
    notifyListeners();
  }

  
  int getQuantityForProduct(Product product) {
    final index = _orderItems.indexWhere((item) => item.product.id == product.id);
    return index != -1 ? _orderItems[index].quantity : 1;
  }
}
