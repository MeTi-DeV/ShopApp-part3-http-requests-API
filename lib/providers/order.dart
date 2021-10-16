import 'package:flutter/material.dart';
import './cart.dart';

//comment 1 : create order provider for save data and pass different parameters and show user orders
class OrderItem {
  final String id;
  final double amount;
  final DateTime time;
  final List<CartItem> products;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.time,
      required this.products});
}
//comment 2 : here create orders list
class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }
//comment 3 : create addToOrder  a function for put all cart items to OrdersScreen
// and show total amout and dateTime of create order
//first argument get our cart data and second argument get total amount
  void addToOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          time: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}
