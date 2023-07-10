// ignore_for_file: unused_field, camel_case_types, avoid_types_as_parameter_names, unused_local_variable, void_checks, prefer_typing_uninitialized_variables, prefer_final_fields, unused_element

import 'package:flutter/cupertino.dart';

class cartitem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  cartitem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class cart with ChangeNotifier {
  Map<String, cartitem> items = {};
  Map<String, cartitem> get _items {
    return {...items};
  }

  int get itemcount {
    return items.length;
  }

  double? get amount {
    var total = 0.0;

    items.forEach((key, cartitem) {
      total = total + (cartitem.price * cartitem.quantity);
    });
    return total;
  }

  void additem(String prodid, double price, String title) {
    if (items.containsKey(prodid)) {
      items.update(
          prodid,
          (exixtingitem) => cartitem(
              id: exixtingitem.id,
              title: exixtingitem.title,
              quantity: exixtingitem.quantity + 1,
              price: exixtingitem.price));
    } else {
      items.putIfAbsent(
          prodid,
          () => cartitem(
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeit(String productid) {
    items.remove(productid);
    notifyListeners();
  }

  void undofun(String prodid) {
    if (!items.containsKey(prodid)) {
      return;
    }
    if (items[prodid]!.quantity > 1) {
      items.update(
          prodid,
          (value) => cartitem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price));
    } else {
      items.remove(prodid);
    }
    notifyListeners();
  }

  void clear() {
    items = {};
    notifyListeners();
  }
}
