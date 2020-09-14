import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/UI/Screens/placeOrder.dart';

class DisplayBuyButtons extends StatelessWidget {
  final DocumentSnapshot product;

  const DisplayBuyButtons({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            RaisedButton(
              child: Text('Add to cart'),
              color: Colors.amber,

              // Navigate to Place Order screen
              // no need to use bloc
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PlaceOrder.routeName, arguments: product);
              },
            ),
            SizedBox(width: 10),
            RaisedButton(
              child: Text('Buy now'),
              color: Colors.amber,
              onPressed: () {},
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
