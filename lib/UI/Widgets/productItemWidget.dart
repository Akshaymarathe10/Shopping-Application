import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/UI/Screens/productDetailScreen.dart';

class ProductItemWidget extends StatelessWidget {
  final DocumentSnapshot productSnapshot;

  const ProductItemWidget({this.productSnapshot});
  @override
  Widget build(BuildContext context) {
    // DocumentSnapshot ds = snapshot.data.documents[productIndex];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: productSnapshot);
          },
          child: Image.network(
            productSnapshot['imageUrl'],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Icon(Icons.favorite),
          title: Text(
            '${productSnapshot['productName']}',
            textAlign: TextAlign.center,
          ),
          trailing: Icon(Icons.add_shopping_cart),
        ),
      ),
    );
  }
}
