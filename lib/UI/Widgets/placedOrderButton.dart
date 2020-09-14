import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/PlaceOrder/placeorder_bloc.dart';
import 'package:my_farm_app/UI/Screens/orderSummery.dart';

class PlaceOrderButton extends StatefulWidget {
  final DocumentSnapshot product;

  const PlaceOrderButton({Key key, this.product}) : super(key: key);

  @override
  _PlaceOrderStateButton createState() => _PlaceOrderStateButton();
}

class _PlaceOrderStateButton extends State<PlaceOrderButton> {
  DocumentSnapshot get _product => widget.product;
  int counter = 0;
  PlaceorderBloc _placeorderBloc;
  @override
  void initState() {
    _placeorderBloc = BlocProvider.of<PlaceorderBloc>(context);
    _placeorderBloc.add(IncreamentCounter(counter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceorderBloc, PlaceorderState>(
      listener: (context, state) {},
      child: BlocBuilder<PlaceorderBloc, PlaceorderState>(
        builder: (context, state) {
          if (state is CartItemCounterInitial) {
            return Container();
          }
          if (state is CartItemCounterLoaded) {
            return Center(
              child: Row(
                children: [
                  Container(
                    child: IconButton(
                      splashRadius: 10,
                      color: Colors.orangeAccent,
                      iconSize: 60,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _placeorderBloc.add(IncreamentCounter(state.counter));
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Text(
                      "${state.counter}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: state.counter <= 0
                        ? IconButton(
                            icon: Icon(Icons.nature),
                            onPressed: null,
                          )
                        : IconButton(
                            highlightColor: Colors.black45,
                            iconSize: 60,
                            color: Colors.cyan,
                            icon: Icon(Icons.minimize),
                            onPressed: () {
                              _placeorderBloc.add(
                                DecreamentCounter(state.counter),
                              );
                            },
                          ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.amberAccent,
                      child: Text('Add to Cart'),
                      onPressed: () {
                        _placeorderBloc.add(PutOrder(_product));
                        Navigator.of(context)
                            .pushNamed(OrderSummeryParent.routeName);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
