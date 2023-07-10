// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import '/providers/orders.dart' show Orders;
import '/widgets/order_item.dart';

class orderscreen extends StatefulWidget {
  //const orderscreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  State<orderscreen> createState() => _orderscreenState();
}

class _orderscreenState extends State<orderscreen> {
  // var _isint = true;
  // var _isloading = false;
  // @override
  // void didChangeDependencies() {
  //   setState(() {
  //     _isloading = true;
  //   });
  //   if (_isint) {
  //     Provider.of<Orders>(context).fetchandsetorders().then((value) {
  //       setState(() {
  //         _isloading = false;
  //       });
  //     });
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    //print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: appdrawer(),
      body:
          // _isloading
          //     ? Center(
          //         child: CircularProgressIndicator(color: Colors.orange),
          //       )
          //:
          FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchandsetorders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => orderite(Order: orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
