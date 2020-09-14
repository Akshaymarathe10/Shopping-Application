import 'package:flutter/material.dart';

class BillArgument {
  final AsyncSnapshot<dynamic> snapShot;
  final double totalPrice;

  BillArgument(this.snapShot, this.totalPrice);
}
