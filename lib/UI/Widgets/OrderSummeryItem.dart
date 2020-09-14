import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildOrderSummeryItem extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const BuildOrderSummeryItem({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 200,
          child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 40,
                    bottom: 40,
                  ),
                  child: buildImage(snapshot),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 170,
                    bottom: 40,
                  ),
                  child: buildProductData(snapshot),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImage(DocumentSnapshot snapshot) {
    return Image.network(
      snapshot['productUrl'],
      width: 150,
    );
  }

  Widget buildProductData(DocumentSnapshot snapshot) {
    return Column(
      children: <Widget>[
        buildProductNameContainer(snapshot),
        buildProductPriceContainer(snapshot),
        buildProductQuantityContainer(snapshot),
        buildProductAmountContainer(snapshot),
      ],
    );
  }

  Container buildProductAmountContainer(DocumentSnapshot snapshot) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 5),
      child: Text(
        'Amount: ${snapshot['amount']}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildProductQuantityContainer(DocumentSnapshot snapshot) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 5),
      child: Text(
        'Quantity: ${snapshot['quantity']}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildProductPriceContainer(DocumentSnapshot snapshot) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 5),
      child: Text(
        'Price: ${snapshot['productPrice']} Rs',
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildProductNameContainer(DocumentSnapshot snapshot) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        snapshot['productName'],
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
