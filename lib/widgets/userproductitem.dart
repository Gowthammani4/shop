// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/editscreen.dart';

class Userproductitem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageurl;
  const Userproductitem(
      {required this.title, required this.imageurl, required this.id});

  @override
  Widget build(BuildContext context) {
    var usersinfo = Provider.of<Products>(context).userid;
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Editscrreen.routeName, arguments: id);
                },
                icon: const Icon(Icons.edit, color: Colors.purple)),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteproduct(id!);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 235, 55, 42),
                ))
          ],
        ),
      ),
    );
  }
}
