// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/carts.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    //when we use the aboue code the whole method will re-run
    //By the below consumer the particular widget which gets the product data will only be renderd

    //Consumer<Product>(builder:(ctx,product,child)=>
    final carti = Provider.of<cart>(context);
    final authi = Provider.of<auth>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Hero(tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('assets/image/rudhra.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            )
            // Image.network(
            //   product.imageUrl,
            //   fit: BoxFit.cover,
            // ),
            ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading:
              //By the below consumer the particular widget which gets the product data will only be renderd
              IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Colors.orange,
            onPressed: () {
              product.toggleFavoriteStatus(
                  product.id.toString(), authi.token, authi.userid);
            },
          ),
          //child can also be there for consumer but whenever it rebuilds the child wont rebuilts it is a static

          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
            onPressed: () {
              carti.additem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text('Added to the cart'),
                duration: Duration(milliseconds: 2),
                action: SnackBarAction(
                    label: 'undo',
                    onPressed: () {
                      carti.undofun(product.id);
                    }),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
