import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart' show Order;
import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(
          orderData.orders[i],
        ),
      ),
    );
  }
}
