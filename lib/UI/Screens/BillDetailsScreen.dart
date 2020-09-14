import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/CarouselImagesBloc/carouselimages_bloc.dart';
import 'package:my_farm_app/Blocs/Orders/orders_bloc.dart';
import 'package:my_farm_app/Blocs/TrendingBloc/trending_bloc.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Screens/dashBoard.dart';

class BillDetails extends StatelessWidget {
  static const routeName = '/billDetails';
  final AsyncSnapshot<dynamic> order;
  final double totalPrice;
  final DBRepo dBRepo = DBRepo();

  BillDetails({Key key, this.order, this.totalPrice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 200,
              padding: EdgeInsets.only(top: 20, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Order Now',
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 10,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Shipping to:  ${order.data.documents[0].data['address']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Items: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '$totalPrice',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Delivery: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '120',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Order Total: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${totalPrice + 120}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: BuildRaisedButtonParent(order: order),
            ),
          ],
        ),
      ),
    );
  }
}

// Class which holds bloc to trigger event for storing order in db
class BuildRaisedButtonParent extends StatelessWidget {
  final AsyncSnapshot<dynamic> order;
  final DBRepo dBRepo = DBRepo();
  BuildRaisedButtonParent({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(dbRepo: dBRepo),
      child: BuildRaisedButton(order: order),
    );
  }
}

class BuildRaisedButton extends StatefulWidget {
  final AsyncSnapshot<dynamic> order;
  const BuildRaisedButton({Key key, this.order}) : super(key: key);

  @override
  _BuildRaisedButtonState createState() => _BuildRaisedButtonState();
}

class _BuildRaisedButtonState extends State<BuildRaisedButton> {
  AsyncSnapshot<dynamic> get _order => widget.order;

  CarouselimagesBloc _carouselimagesBloc;
  TrendingBloc _trendingBloc;

  OrdersBloc _orderBloc;
  @override
  void initState() {
    _carouselimagesBloc = BlocProvider.of<CarouselimagesBloc>(context);
    // _trendingBloc = BlocProvider.of<TrendingBloc>(context);
    // _orderBloc = BlocProvider.of<OrdersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Place your order'),
      color: Colors.amberAccent,
      onPressed: () {
        _orderBloc.add(PutOrder(_order));
        _carouselimagesBloc.add(GetCarouselImages());
        _trendingBloc.add(GetTrendingImages());

        Navigator.of(context).pushNamed(DashBoard.routeName);
      },
    );
  }
}
