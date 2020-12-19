import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  /* var _showFavoritesOnly = false; */

  List<Product> get items {
    /* if (_showFavoritesOnly) {
      return [..._items].where((item) => item.isFavorite).toList();
    } */
    // return a copy of the items not the items itself
    return [..._items];
  }

  List<Product> get favoritesItmes {
    return _items.where((item) => item.isFavorite).toList();
  }

/* 
  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
 */
  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://xessshop-7568b-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      print(response);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
    } catch (erro) {
      throw (erro);
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://xessshop-7568b-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://xessshop-7568b-default-rtdb.firebaseio.com/products/$id.json';
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }),
        );
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (erro) {
        throw erro;
      }
    } else {
      print('...');
    }
  }
 Future<void> updateFavorites(String id, bool newFav) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://xessshop-7568b-default-rtdb.firebaseio.com/products/$id.json';
      try {
        await http.patch(
          url,
          body: json.encode({
            'isFavorite': newFav,
          }),
        );
        
        notifyListeners();
      } catch (erro) {
        throw erro;
      }
    } else {
      print('...');
    }
  }
  void deleteProduct(String procductId) {
    final url =
        'https://xessshop-7568b-default-rtdb.firebaseio.com/products/$procductId.json';
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == procductId);
    var existingProduct = _items[existingProductIndex];

    _items.removeWhere((prod) => prod.id == procductId);
    http.delete(url).then((_) {
      existingProduct = null;
    }).catchError((erro) {
      _items.insert(existingProductIndex, existingProduct);
    });
    notifyListeners();
  }

}
