import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../providers/products_provider.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '\product-detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productData = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);
    double rate = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                productData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productData.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    '\$${productData.price}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  FittedBox(
                    child: RatingBar.builder(
                      allowHalfRating: true,
                      initialRating: rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(productData.description),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Provider.of<Cart>(context, listen: false).addItems(
            price: productData.price,
            title: productData.title,
            productId: productId,
          );
        },
      ),
    );
  }
}
