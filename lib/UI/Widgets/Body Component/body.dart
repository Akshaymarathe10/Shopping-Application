import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/UI/Widgets/Body%20Component/displayBuyButtons.dart';
import 'package:my_farm_app/UI/Widgets/Body%20Component/displayComments.dart';
import 'package:my_farm_app/UI/Widgets/Body%20Component/displayImage.dart';
import 'package:my_farm_app/UI/Widgets/Body%20Component/displayTitle.dart';
import 'package:my_farm_app/constants/constant.dart';

class Body extends StatelessWidget {
  final DocumentSnapshot product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.03,
              left: kDefaultPaddin,
              right: kDefaultPaddin,
            ),
            child: Column(
              children: <Widget>[
                DisplayTitle(product: product),
                DisplayImage(product: product),
                DisplayBuyButtons(product: product),
                SizedBox(height: 10),
                DisplayComments(product: product),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
