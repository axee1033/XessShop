import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  const UserProductItem({Key key, this.id, this.title, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (erro) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      'Deleting failed',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
