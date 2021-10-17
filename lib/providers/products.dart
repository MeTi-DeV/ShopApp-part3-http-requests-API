import 'package:flutter/material.dart';
import 'product.dart';
//comment 1: after created account in Google Firebase add http package and set it as test database
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    //comment 2 : for add new product to Firebase first define a variable to save  database url in items

    final url = Uri.https(
      //comment 3 : use Uri.https and paste url here without https and for second parameters add json file name like here i choose /products.json
        'shopapp-82387-default-rtdb.asia-southeast1.firebasedatabase.app', '/products.json');
//comment 4 : for pass data or add new data to database use .post() get 2 parameters at this time
// first argument: our url 
//second argument: is body , body say add your json inside me with all parameters
//for do this import dart:convert for use encode
//json.encode({}): convert all products parameters as json data for pass this data to the database
    http
        .post(
      url,
      body: json.encode(
        {
          "title": product.title,
          "price": product.price,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
      
    )
    //comment 5 :.then() : use this method for when we want to show changes with some delay
    // here after complate all fields of new product and save it till it is uploading on data base and save there
        .then(
      (response) {
        final newProduct = Product(
          //comment 6 : in database when add new product firebase generate new id and use it here as unique id
            id: json.decode(response.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl);

        _items.insert(0, newProduct);
        notifyListeners();
      },
    );
  }

  void updateProduct(String id, Product newProduct) {
    final proIndex = items.indexWhere((prod) => prod.id == id);

    if (proIndex >= 0) {
      _items[proIndex] = newProduct;
      print(proIndex);
      notifyListeners();
    } else {
      print('...');
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
