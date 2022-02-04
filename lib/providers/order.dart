import 'dart:convert';

import 'package:flutter/material.dart';
import './cart.dart';
import 'package:http/http.dart' as http;

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

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }
//comment 1 : add orders to web service
  Future<void> addToOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
        'flutter-shop-b4316-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/orders.json');
        //comment 2 : define a variable to get dateTime.now() and we have a one type of time for app and web service
    final stampTime = DateTime.now().toIso8601String();
    //comment 3 : next step post data to web service like product
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'time': stampTime,
          //comment 4 : pass product data as lis of data to webservice
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          time: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}
