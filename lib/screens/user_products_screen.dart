// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/editscreen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/userproductitem.dart';

class Userproductscreen extends StatefulWidget {


  Userproductscreen();
  static const routeName = '/userproducts';

  @override
  State<Userproductscreen> createState() => _UserproductscreenState();
}

class _UserproductscreenState extends State<Userproductscreen> {
  Future<void> _refreshpage(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchandsetproduct(true);
  }

  @override
  Widget build(BuildContext context) {
    // final prod = Provider.of<Products>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Editscrreen.routeName, arguments: '');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: appdrawer(),
      body: FutureBuilder(
        future: _refreshpage(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshpage(context),
                    child: Consumer<Products>(
                      builder: (ctx, prod, _) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListView.builder(
                          itemCount: prod.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              Userproductitem(
                                title: prod.items[i].title,
                                imageurl: prod.items[i].imageUrl,
                                id: prod.items[i].id,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
