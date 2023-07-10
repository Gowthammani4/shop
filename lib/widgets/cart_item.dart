// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/carts.dart';

class Cartsitem extends StatelessWidget {
  final double price;
  final String id;
  final String prodid;
  final int quantity;
  final String title;
  Cartsitem(
      {required this.price,
      this.id = '',
      required this.quantity,
      required this.prodid,
      required this.title});

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
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
      onDismissed: (DismissDirection) {
        prod.removeit(prodid);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are you sure?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Text('you want delete the item from the cart?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes')),
                  ],
                ));
        //return Future.value(true);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('\$$price'),
            ),
            title: Text(title),
            subtitle: Text('Total:\$${(price * quantity)}'),
            trailing: Text('${quantity}x'),
          ),
        ),
      ),
    );
  }
}
