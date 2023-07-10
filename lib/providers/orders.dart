// ignore_for_file: unused_import, prefer_final_fields, camel_case_types, avoid_function_literals_in_foreach_calls, unused_local_variable, avoid_print, unnecessary_null_comparison, unused_element

import 'dart:convert';
// 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/carts.dart';
import 'package:shop/widgets/cart_item.dart';
import '/providers/carts.dart';
import 'package:http/http.dart' as http;

class orderitem {
  final String id;
  final double amount;
  final List<cartitem> products;
  final DateTime datetime;

  orderitem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.datetime});
}

class Orders with ChangeNotifier {
  List<orderitem> _orders = [];
  List<orderitem> get orders {
    return [..._orders];
  }

  String? _authToken;
  set authToken(String? value) {
    _authToken = value;
  }

  String? userid;
  set _id(String? value) {
    userid = value;
  }

  Future<void> fetchandsetorders() async {
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/orders/$userid.json', {'auth': '$_authToken'});
    var response = await http.get(url);
    print(response.body);

    final List<orderitem> loadedorders = [];
    var _extracteddata = json.decode(response.body) as Map<String, dynamic>;

    if (_extracteddata == null) {
      return;
    }

    _extracteddata.forEach((orderId, orderData) {
      loadedorders.add(orderitem(
        id: orderId,
        amount: orderData['amount'],
        datetime: DateTime.parse(orderData['datetime']),
        products: (orderData['Products'] as List<dynamic>)
            .map(
              (item) => cartitem(
                id: item['id'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title'],
              ),
            )
            .toList(),
      ));
    });

    _orders = loadedorders.reversed.toList();
    notifyListeners();
  }

  void removeit(String orderid) {
    _orders.removeWhere((element) => element.id == orderid);
    notifyListeners();
  }

  Future<void> addOrder(List<cartitem> cartproducts, double total) async {
    List<cartitem> _loadedprod = cartproducts;
    final timestamp = DateTime.now();
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/orders/$userid.json', {'auth': '$_authToken'});
    var response = await http.post(url,
        body: json.encode({
          'amount': total,
          'datetime': timestamp.toIso8601String(),
          'Products': cartproducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }));

    _orders.insert(
        0,
        orderitem(
            datetime: timestamp,
            amount: total,
            id: json.decode(response.body)['name'],
            products: cartproducts));

    notifyListeners();
  }

  void deleteorder(String id) {
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/orders/$userid/$id.json', {'auth': '$_authToken'});
    final existingindex = _orders.indexWhere((element) => element.id == id);
    orderitem? existingproduct = _orders[existingindex];
    _orders.removeAt(existingindex);
    notifyListeners();
    http.delete(url).then((_) {
      existingproduct = null;
    }).catchError((_) {
      _orders.insert(existingindex, existingproduct!);
      notifyListeners();
    });
  }
}
