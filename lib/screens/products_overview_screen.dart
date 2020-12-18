

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/main_drawer.dart';
import '../providers/cart.dart';

enum FilterOption { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const rounteName ='/';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavortiesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showFavortiesOnly = true;
                } else {
                  _showFavortiesOnly = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOption.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOption.All,
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CartScreen.routeName,
                );
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showFavortiesOnly),
    );
  }
}

