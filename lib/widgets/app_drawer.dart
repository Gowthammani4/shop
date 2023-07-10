// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/Customroute.dart';
import 'package:shop/livescore.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/user_products_screen.dart';

import '../providers/products.dart';

class appdrawer extends StatelessWidget {
  bool islight = false;
  appdrawer();

  @override
  Widget build(BuildContext context) {
    var usersinfo = Provider.of<Products>(context).userid;
    // var fav = Provider.of<Product>(context);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'shop app',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         fav.tooglethememode(islight);
            //       },
            //       icon: Icon(islight ? Icons.light_mode : Icons.dark_mode))
            // ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () {
              //Navigator.of(context).push(Customroute((ctx)=>orderscreen()));
              Navigator.of(context).pushNamed(orderscreen.routeName);
            },
          ),
          Divider(),
          usersinfo == "WZMJsPF9VzZp2aqAjxoNWgmkldD3"
              ? ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Manage products'),
                  onTap: () {
                    print(usersinfo);
                    usersinfo == "WZMJsPF9VzZp2aqAjxoNWgmkldD3"
                        ? Navigator.of(context)
                            .pushReplacementNamed(Userproductscreen.routeName)
                        : {
                            Navigator.of(context).pop(),
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text(
                                    'Sorry! Only admins can add products')))
                          };
                  },
                )
              : Text(''),
          ListTile(
            leading: Icon(Icons.score_rounded),
            title: Text('Football scores'),
            onTap: () {
              Navigator.of(context).pushNamed(Soccer.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.score_rounded),
            title: Text('Cricket scores'),
            onTap: () {
              Navigator.of(context).pushNamed(cricket.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<auth>(context, listen: false).logout();

              // Navigator.of(context)
              //     .pushReplacementNamed(Userproductscreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
