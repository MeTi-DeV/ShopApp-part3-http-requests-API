import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart' show Order;
import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Order List'),
      ),
//comment 1 : an other way to send future is useing FutureBuilder()

      body: FutureBuilder(
        //comment 2 : it has 2 properties
        //future : is to set our future function to fetch data to list order
        future: Provider.of<Order>(context, listen: false).setAndFetchOrders(),
        //builder: (context ,snapshot)
        builder: ((context, snapshot) {
          //snapshot: is to determine of current situation of request
//if it is waiting show CircularProgressIndicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            //Otherwise is there any erorr show a Text
          } else {
            if (snapshot.error != null) {
              //...
              //Do error stuff
              return Center(
                child: Text('An error occured'),
              );
              //and if every thing is ok show my order list
            } else {
              //comment 3 : FutureBuilder use for data that not change every time in cliet side and we just show them and not logic apply on them
              //is recommend way to use FutureBuilder for our screen or widget

              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(
                    orderData.orders[i],
                  ),
                ),
              );
            }
          }
        }),
      ),
    );
  }
}
//---- End Of http and APIs in Flutter ----
