import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartItem {
  // final String name;
  // final String address;
  // final String productName;
  // final double productPrice;
  // final String productUrl;
  final int quantity;
  // final double amount;

  CartItem({
    // this.name,
    //this.address,
    //this.productName,
    //this.productPrice,
    //this.productUrl,
    this.quantity,
    //this.amount,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  void cartItem() async {
    _items.clear();
    var firestoreInstance = Firestore.instance;
    var user = await FirebaseAuth.instance.currentUser();

    await firestoreInstance
        .collection('placeOrder')
        .document(user.uid)
        .collection('subPlaceOrder')
        .snapshots()
        .forEach(
      (element) {
        _items.add(
          CartItem(
            quantity: element.documents.length,
          ),
        );
      },
    );
    notifyListeners();
  }
}
