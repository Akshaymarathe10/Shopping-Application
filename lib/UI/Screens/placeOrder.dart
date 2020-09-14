import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/PlaceOrder/placeorder_bloc.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Widgets/placedOrderButton.dart';

class PlaceOrder extends StatelessWidget {
  static const routeName = '/placeOrder';
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(50),
                height: 600,
                child: Image.network(
                  product['imageUrl'],
                ),
              ),
              Container(
                child: PlaceOrderButtonParent(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceOrderButtonParent extends StatelessWidget {
  final DocumentSnapshot product;
  final DBRepo dBRepo = DBRepo();
  PlaceOrderButtonParent({this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceorderBloc(dbRepo: dBRepo),
      child: PlaceOrderButton(product: product),
    );
  }
}
