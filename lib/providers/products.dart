import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get FavoriteList {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  void addProducts(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    //comment 1 : for add new created product can use insert or add methods but different between these methods
    // is if use Insert() add new product in top of list
    //but if use Add() add new product to Following list
    _items.insert(0, newProduct);
    notifyListeners();
  }

  //comment 2 : must important function is this function for make editable all products that will be added or was in our list
  //comment 3 : first define parameters for function need ID of product and pass data of product we resivied in EditProductScreen
  // as second parameter
  void updateProduct(String id, Product newProduct) {
    //comment 4 : at the first use .indexWhere() for find specific product that has an unique id and we created it time ago
    // here we call this product again by define a variable like prodIndex
    // return value of items.indexWhere((prod) => prod.id == id) is a place of product in list product array for example: maybe that product has a unique id : 'p2' and the place of this id is [1]
    // we save the product place number in product list array or(_items) in prodIndex
    final proIndex = items.indexWhere((prod) => prod.id == id);
    //comment 5 : then create an if statement Which it determines(معین میکند)if there was a product with place number in product list array or(_items)

    if (proIndex >= 0) {
      // instead new data or edited previous product data to current product data and
      //How?
      // pass product number place like this : _items[prodIndex]
      // and replace old data of this product with new data
      // when define _items[prodIndex]=newProduct
      _items[proIndex] = newProduct;
      print(proIndex);
      notifyListeners();
    }
    //comment 6 : otherwise do nothing
    else {
      print('...');
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
