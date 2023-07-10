// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, camel_case_types, dead_code, use_rethrow_when_possible

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders, orderitem;

class orderite extends StatefulWidget {
  // final double price;
  // final String id;
  // final String prodid;
  // final int quantity;
  // final String title;
  final orderitem Order;
  orderite({
    required this.Order,
  });

  @override
  State<orderite> createState() => _orderiteState();
}

class _orderiteState extends State<orderite> {
  // orderite({required this.price,required this.id,required this.prodid,required this.quantity,required this.title});
  @override
  Widget build(BuildContext context) {
    var odi = Provider.of<Orders>(context, listen: false);
    bool _expanded = true;
    return Dismissible(
      onDismissed: (dirction) {
        try {
          odi.deleteorder(widget.Order.id);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Order deleted successfully')));
        } catch (e) {
          throw (e);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$e')));
        }
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      key: ValueKey(widget.Order.id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                title: Text('${widget.Order.amount}'),
                subtitle: Text('${widget.Order.datetime}'),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !(_expanded);
                      // if (_expanded) {
                      //   _expanded = false;
                      // } else {
                      //   _expanded = true;
                      // }
                    });
                  },
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ),
              ),
              if (_expanded)
                Container(
                    height: min(widget.Order.products.length * 20.0 + 10, 100),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    child: ListView(
                      children: widget.Order.products
                          .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Divider(),
                                  Text(
                                    '${e.quantity}x  \$${e.price}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  )
                                ],
                              ))
                          .toList(),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
