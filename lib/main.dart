// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_single_cascade_in_expression_statements, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/Customroute.dart';
import 'package:shop/livescore.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/carts.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/authscreen.dart';
import 'package:shop/screens/editscreen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/splash_screen.dart';
import 'package:shop/screens/user_products_screen.dart';
import '/screens/cart_screen.dart';
import '/providers/products.dart';
import '/screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: auth(),
        ),
        ChangeNotifierProxyProvider<auth, Products>(
          update: (context, authi, previous) {
            previous!..authToken = authi.token;

            previous..userid = authi.userid;
            return previous;
          },
          create: (_) => Products(),
        ),
        ChangeNotifierProvider.value(value: cart()),
        ChangeNotifierProxyProvider<auth, Orders>(
            update: (context, value, previous) {
              previous!..authToken = value.token;
              previous..userid = value.userid;
              return previous;
            },
            create: (_) => Orders())
      ],
      child: Consumer<auth>(
        builder: (context, authi, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My shop',
          theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(
                  builders: {TargetPlatform.android: custompagetransition()}),
              primaryColor: Colors.purple,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange)),
          home: authi.isauth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authi.tryautologin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Splashscreen()
                          // Center(child: Text('Loading'))
                          : AuthScreen(),
                ),
          routes: {
            Soccer.routeName: (ctx) => Soccer(),
            cricket.routeName: (ctx) => cricket(),
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            Cartscreen.routeName: (ctx) => Cartscreen(),
            orderscreen.routeName: (ctx) => orderscreen(),
            Userproductscreen.routeName: (ctx) => Userproductscreen(),
            Editscrreen.routeName: (ctx) => Editscrreen()
          },
        ),
      ),
    );
  }
}
