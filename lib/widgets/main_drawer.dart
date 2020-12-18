

import 'package:flutter/material.dart';

import '../screens/orders_Screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/user_product_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.network(
                "https://pbs.twimg.com/media/Dicziz1WkAAEU4W.jpg",
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text("Shop"),
              leading: Icon(Icons.shop),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.rounteName),
            ),
            ListTile(
              title: Text("My Products"),
              leading: Icon(Icons.person),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName),
            ),
            ListTile(
              title: Text("My Orders"),
              leading: Icon(Icons.credit_card),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName),
            ),
           
          ],
        ),
      ),
    );
  }
}
