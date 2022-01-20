import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
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
  var _isinitState = true;
  @override
  //comment 1 : we can use our fetch data function here as initState for in state we can call peovide function with listen:false
  //and Futere.Deleyed but there is an other ways
// void initState() {
//   super.initState();
//   Provider.of<Products>(context , listen: false).fetchAndSetProducts();
//   Future.delayed(Duration.zero).then((_){
//     Provider.of<Products>(context).fetchAndSetProducts()
//   });
// }
//comment 2 : at later used didChangeDependencies it's an other way to call fetch function
  void didChangeDependencies() {
    if (_isinitState) {
      Provider.of<Products>(context).fetchAndSetProducts();
    }
    _isinitState = false;
    super.didChangeDependencies();
  }

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
