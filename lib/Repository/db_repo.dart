import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_farm_app/Model/addProductCounter.dart';
import 'package:my_farm_app/Model/userData.dart';
import 'package:my_farm_app/Model/placedOrder.dart';

class DBRepo {
  int cartLength;
  // List for User Data
  List<UserData> _userData = [];
  List<UserData> get userData {
    return _userData;
  }

// List for Place Order
  List<PlaceOrder> _placedOrder = [];
  List<PlaceOrder> get placedOrder {
    return _placedOrder;
  }

  final firestoreInstance = Firestore.instance;

  var addProductCounter = AddProductCounter();

// Method for getCarouselImages
  Stream<QuerySnapshot> getCarouselImages() {
    return firestoreInstance.collection('carouselImages').snapshots();
  }

  // Method for getCarouselImages
  Stream<QuerySnapshot> getTrendingImages() {
    return firestoreInstance.collection('trendingImages').snapshots();
  }

// Method for getGridImages
  Stream<QuerySnapshot> getGridImages() {
    return firestoreInstance.collection('gridImages').snapshots();
  }

// method for "Add to cart"
  void storeOrder(DocumentSnapshot product, int getCounter) async {
    _userData.clear();
    var user = await FirebaseAuth.instance.currentUser();

    await firestoreInstance
        .collection('users')
        .document(user.uid)
        .snapshots()
        .forEach(
      (element) {
        _userData.add(
          UserData(
            address: element.data['address'],
            fName: element.data['firstName'],
          ),
        );
        _userData.forEach(
          (element) {
            int amount = product['price'] * getCounter;
            firestoreInstance
                .collection('placeOrder')
                .document(user.uid)
                .collection('subPlaceOrder')
                .add(
              {
                'name': element.fName,
                'address': element.address,
                'uId': user.uid,
                'productName': product['productName'],
                'productPrice': product['price'],
                'productUrl': product['imageUrl'],
                'quantity': getCounter,
                'amount': amount,
              },
            ).whenComplete(
              () => print('Order successfully placed !'),
            );
          },
        );
      },
    );
  }

// Method for fetchOrderSummery to display on OrderSummery Screen

  Future<QuerySnapshot> fetchOrderSummery() async {
    var user = await FirebaseAuth.instance.currentUser();
    return firestoreInstance
        .collection("placeOrder")
        .document(user.uid)
        .collection("subPlaceOrder")
        .getDocuments();
  }

// Method for fetchOrderSummery to display on BillDetails Screen
  Future userOrders(AsyncSnapshot<dynamic> order) async {
    var user = await FirebaseAuth.instance.currentUser();
    cartLength = order.data.documents.length;
    for (var i = 0; i < cartLength; i++) {
      firestoreInstance
          .collection('orders')
          .document(user.uid)
          .collection('subOrderCollection')
          .add(
        {
          'name': order.data.documents[i].data['name'],
          'address': order.data.documents[i].data['address'],
          'uId': order.data.documents[i].data['uId'],
          'productName': order.data.documents[i].data['productName'],
          'productPrice': order.data.documents[i].data['productPrice'],
          'productUrl': order.data.documents[i].data['productUrl'],
          'quantity': order.data.documents[i].data['quantity'],
          'amount': order.data.documents[i].data['amount'],
        },
      );
    }
  }
}
