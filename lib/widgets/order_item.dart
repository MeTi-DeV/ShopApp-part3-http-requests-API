import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart' as orde;

class OrderItem extends StatefulWidget {
  final orde.OrderItem order;
  OrderItem(this.order);
//comment 1 : make statefulWidget for show more detail on each order item
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  //comment 2 : define this variable for expand_less and expand_more for show more details of each order
  var isShowMore = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            //comment 3 : here we see total amount of cart list
            title: Text('\$ ${widget.order.amount}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text(
              //comment 4 : here we see the date of created order
              DateFormat.MMMMEEEEd().format(widget.order.time),
            ),
            trailing: IconButton(
              //comment 5 : make this button for manage the more detail and less details
              onPressed: () {
                setState(() {
                  isShowMore = !isShowMore;
                });
              },
              icon: Icon(isShowMore ? Icons.expand_less : Icons.expand_more),
            ),
          ),
           //comment 6 : this if statement is for show more details and use min() from dart:math for increase height of order details 
          if (isShowMore)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20 + 10, 100),
              child: ListView(
                children: [
                  ...widget.order.products.map(
                    (product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.title , style:TextStyle(fontSize: 18 , fontWeight:FontWeight.bold),),
                          Text(
                            '${product.quantity}x ${product.price} \$',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      );
                    },
                  ).toList()
                ],
              ),
            ),
        ],
      ),
    );
  }
}
