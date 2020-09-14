import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/constants/constant.dart';

class DisplayTitle extends StatelessWidget {
  final DocumentSnapshot product;

  const DisplayTitle({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
        child: Text(
          product['productName'],
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
