import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final DocumentSnapshot product;

  const DisplayImage({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.network(product['imageUrl']);
  }
}
