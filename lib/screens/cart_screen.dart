// ignore_for_file: prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors, empty_catches, avoid_unnecessary_containers, await_only_futures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop/widgets/cart_item.dart';
import '/providers/carts.dart' show cart;
import '/providers/orders.dart';

class Cartscreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${carts.amount!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(carti: carts)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: carts.items.length,
              itemBuilder: (ctx, i) => Cartsitem(
                id: carts.items.values.toList()[i].id,
                prodid: carts.items.keys.toList()[i],
                price: carts.items.values.toList()[i].price,
                quantity: carts.items.values.toList()[i].quantity,
                title: carts.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final cart carti;

  const OrderButton({
    required this.carti,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  final _razorpay = Razorpay();
  void _payment(amt) {
    var options = {
      'key': "rzp_test_bT6PAObwyDEx7u",
      // amount will be multiple of 100
      'amount': (amt * 100).toString(),
      // (int.parse(amountController.text) * 100)
      //  .toString(), //So its pay 500
      'name': '',
      'description': '',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': ''
        //_data['phone number']
        ,
        'email': ''
        // _data['mailid']
      }
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ElevatedButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.carti.amount! <= 0 || _isLoading)
          ? null
          : () async {
              _payment(widget.carti.amount);
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.carti.items.values.toList(),
                widget.carti.amount as double,
              );
              setState(() {
                _isLoading = false;
              });
              widget.carti.clear();
            },
      // textColor: Theme.of(context).primaryColor,
    );
  }
}
