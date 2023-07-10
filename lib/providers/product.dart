import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  late final String id;
  late final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  bool islight;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.islight=false,
  });

  Future<void> toggleFavoriteStatus(
      String? id, String? token, String? userid) async {
    isFavorite = !isFavorite;
    final url = Uri.https('sample-ddda4-default-rtdb.firebaseio.com',
        '/userFavorites/$userid/$id.json', {'auth': '$token'});
    await http.put(url, body: json.encode(isFavorite));

    notifyListeners();
  }

  bool tooglethememode(isdark) {
    isdark = !isdark;
    return isdark;
  }
}
