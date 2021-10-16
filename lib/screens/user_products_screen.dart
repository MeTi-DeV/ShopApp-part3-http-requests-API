import 'package:flutter/material.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import '../providers/products.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=>Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Manage Products'),
      ),
      body: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (BuildContext _, int i) {
          return Column(
            children: [
              UserProductItem(productsData.items[i].title,
                  productsData.items[i].imageUrl, productsData.items[i].id),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
