import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../widgets/main_drawer.dart';

enum FavoriteOptions { All, Favorite }

class OverviewProductsScreen extends StatefulWidget {
  @override
  State<OverviewProductsScreen> createState() => _OverviewProductsScreenState();
}

class _OverviewProductsScreenState extends State<OverviewProductsScreen> {
  var _selectFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FavoriteOptions selectedValue) {
              setState(() {
                if (selectedValue == FavoriteOptions.Favorite) {
                  _selectFavorite = true;
                } else {
                  _selectFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Show Favorite'),
                  value: FavoriteOptions.Favorite),
              PopupMenuItem(child: Text('Show All'), value: FavoriteOptions.All)
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/cart'),
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
        title: Text('Shop App'),
      ),
      body: ProductGrid(_selectFavorite),
    );
  }
}
