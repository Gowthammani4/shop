// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

//import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:shop/screens/products_overview_screen.dart';

class Splashscreen extends StatelessWidget {
  // void initState() {
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.of(context)
  //           .pushReplacementNamed(ProductsOverviewScreen.routeName));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
