// ignore_for_file: prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors, avoid_unnecessary_containers, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/carts.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import '../providers/carts.dart';
import '../widgets/products_grid.dart';

// ignore: constant_identifier_names
enum filteroption { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/Product_over';
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isinot = true;
  var _isloading = false;
  @override
  void initState() {
    // ignore: todo
    //TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isinot) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Products>(context).fetchandsetproduct().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isinot = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filteroption selectedValue) {
              setState(() {
                if (selectedValue == filteroption.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: filteroption.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filteroption.All,
              ),
            ],
          ),
          Consumer<cart>(
            builder: (_, carti, ch) => Badge(
              child: ch as Widget,
              value: carti.itemcount.toString(),
              color: Colors.orange,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(Cartscreen.routeName)),
          ),
        ],
      ),
      drawer: appdrawer(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
