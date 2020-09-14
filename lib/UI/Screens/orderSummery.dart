import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/OrderSummery/ordersummery_bloc.dart';
import 'package:my_farm_app/Model/billArgument.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Screens/BillDetailsScreen.dart';
import 'package:my_farm_app/UI/Widgets/OrderSummeryItem.dart';

class OrderSummeryParent extends StatelessWidget {
  // final DocumentSnapshot product;
  final DBRepo dBRepo = DBRepo();
  // OrderSummeryParent({this.product});
  static const routeName = '/order_summery';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersummeryBloc(dbRepo: dBRepo),
      child: OrderSummery(),
    );
  }
}

class OrderSummery extends StatefulWidget {
  @override
  _OrderSummeryState createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  OrdersummeryBloc _ordersummeryBloc;
  double totalPrice;
  @override
  void initState() {
    _ordersummeryBloc = BlocProvider.of<OrdersummeryBloc>(context);
    _ordersummeryBloc.add(GetOrderSummery());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summery'),
      ),
      body: BlocBuilder<OrdersummeryBloc, OrdersummeryState>(
        builder: (context, state) {
          if (state is OrdersummeryLoading) {
            return CircularProgressIndicator();
          } else if (state is OrdersummeryLoaded) {
            Future<QuerySnapshot> order = state.orderSummery;
            return FutureBuilder(
              future: order,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                  );
                } else {
                  calculateTotalPrice(snapshot);
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        // height: 30,
                        child: Text(
                          'Address: ' +
                              snapshot.data.documents[0].data['address'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          snapshot.data.documents[0].data['name'],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              BuildOrderSummeryItem(
                                snapshot: snapshot.data.documents[index],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildProceedButtonContainer(snapshot),
                      SizedBox(height: 20),
                    ],
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void calculateTotalPrice(AsyncSnapshot snapshot) {
    int length = snapshot.data.documents.length;
    totalPrice = 0;
    for (var i = 0; i < length; i++) {
      totalPrice = totalPrice + snapshot.data.documents[i].data['amount'];
      print(totalPrice);
    }
  }

  Container buildProceedButtonContainer(AsyncSnapshot<dynamic> snapshot) {
    return Container(
      padding: EdgeInsets.only(
        left: 100,
        right: 100,
      ),
      child: RaisedButton(
        color: Colors.amber,
        elevation: 10,
        child: Text('Proceed to pay'),
        onPressed: () {
          Navigator.of(context).pushNamed(
            BillDetails.routeName,
            arguments: BillArgument(
              snapshot,
              totalPrice,
            ),
          );
        },
      ),
    );
  }
}
