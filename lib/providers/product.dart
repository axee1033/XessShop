import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStuts() async {
    final url =
        'https://xessshop-7568b-default-rtdb.firebaseio.com/products/$id.json';
    try {
      await http.patch(
        url,
        body: json.encode({
          'isFavorite': !isFavorite,
        }),
      );

      notifyListeners();
    } catch (erro) {
      throw erro;
    }
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
