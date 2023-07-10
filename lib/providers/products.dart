// ignore_for_file: prefer_final_fields, non_constant_identifier_names, avoid_print, unused_label, unused_import, avoid_web_libraries_in_flutter, iterable_contains_unrelated_type, use_rethrow_when_possible, unused_element

// import 'dart:html';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    // if (_showfavoritesonly) {
    //   return items.where((ele) => ele.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String? id) {
    //return _items.firstWhere((prod) => prod.id == id);

    //if (_items.contains(id)) {
    return _items.firstWhere((prod) => prod.id == id);
    // } else {
    //   return _items.first;
    // }
  }

  String? _authToken;
  //Products(this.authToken, this._items);
  set authToken(String? value) {
    _authToken = value;
  }

  String? userid;
  set _userid(String? value) {
    userid = value;
  }
  // String? id;
  // set _id(String? val){
  //   id=val;
  // }

  Future<void> fetchandsetproduct([bool val = false]) async {
    // print(_authToken);
    // var url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
    //     '/products.json', {'auth': '$_authToken'});
    //we can either use above or below to give the firebase link
    String _filterbyusers = val ? 'orderBy="creatorId"&equalTo="$userid"' : '';

    var url = Uri.parse(
        'https://sample-ddda4-default-rtdb.firebaseio.com/products.json?auth=$_authToken&$_filterbyusers');
    try {
      final reponse = await http.get(url);
      print(reponse.body);
      final extracteddata = json.decode(reponse.body) as Map<String, dynamic>;
      List<Product> loadedproducts = [];
      if (extracteddata.isEmpty) {
        return;
      }
      url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
          '/userFavorites/$userid.json', {'auth': '$_authToken'});
      final favrespone = await http.get(url);
      print(favrespone.body);
      final favdata = json.decode(favrespone.body);
      extracteddata.forEach((prodId, prodData) {
        loadedproducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: favdata == null ? false : favdata[prodId] ?? false,
          //the false in the right of ?? is assigned when favdata[prodid] is null
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedproducts;
      notifyListeners();
    } catch (error) {
      print(_authToken);
      throw (error);
    }
    //await json.decode(reponse.);
  }

  List<Product> get favoritesonly {
    return _items.where((ele) => ele.isFavorite).toList();
  }

  // void showfavoritesonly() {
  //   _showfavoritesonly = true;
  //   notifyListeners();
  // }

  // void showall() {
  //   _showfavoritesonly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) {
    notifyListeners();
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/products.json', {'auth': '$_authToken'});
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              //'isFavorite': product.isFavorite,
              'imageUrl': product.imageUrl,
              'creatorId': userid,
            }))
        .then((response) {
      //then is used for future function.Then fun() is executed after the product added to the server
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
        //the line of code will get the id from the
        //firebase database and the decoded
        //id is stored in id,it is a unique key
      );
      _items.add(newProduct);
      // _items.add(value);
      notifyListeners();
    });

    // final newProduct = Product(
    //     title: product.title,
    //     description: product.description,
    //     price: product.price,
    //     imageUrl: product.imageUrl,
    //     id: ''
    //     //id: json.decode(response.body)['name'],
    //     //the line of code will get the id from the
    //     //firebase database and the decoded
    //     //id is stored in id,it is a unique key
    //     );
    // _items.add(newProduct);
    // // _items.add(value);
    // notifyListeners();
  }

  Future<void> updateProduct(String? id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
          '/products/$id.json', {'auth': '$_authToken'});
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            //id: id,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteproduct(String id) {
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/products/$id.json', {'auth': '$_authToken'});
    final existingindex = _items.indexWhere((element) => element.id == id);
    Product? existingproduct = _items[existingindex];
    _items.removeAt(existingindex);
    notifyListeners();

    http.delete(url).then((_) {
      existingproduct = null;
    }).catchError((_) {
      _items.insert(existingindex, existingproduct!);
      notifyListeners();
    });
  }
}
