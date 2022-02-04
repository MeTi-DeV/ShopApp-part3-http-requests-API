import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart' show Order;
import '../widgets/order_item.dart';
import '../widgets/main_drawer.dart';
//comment 1 : change to state full widget for show CircularProgressIndicator till data is fetching
class OrdersScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
  //comment 2 : I explained other way to fetch data is use Future.delayed().then()

    Future.delayed(Duration.zero).then((_) async {
      //comment 3 : set _isLoading to true till data will response
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Order>(context, listen: false).setAndFetchOrders();
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(
                  orderData.orders[i],
                ),
              ),
      ),
    );
  }
}
