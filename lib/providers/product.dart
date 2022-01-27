import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String description;
  final String title;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});
      //comment 4 : to avoid code duplicate define _setFavValue as private function and call in catch(error){} and if
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }
//comment 1 : to pass favorite status have to update product data 
  Future<void> toggledStatusFavorite() async {
    //comment 2 : define oldStatus to return to previous status of favorite if any error occurred
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://flutter-shop-b4316-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
          //comment 3 :for PATCH , DELETE , PUT  connection error occurred with statusCode more than 400
          // for these errors we should get to previous data so define oldStatus for here
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
      notifyListeners();
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
