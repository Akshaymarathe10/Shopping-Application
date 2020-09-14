import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/Authentication/authentication_bloc.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Widgets/carouselSlider.dart';
import 'package:my_farm_app/UI/Widgets/productGridViewWidget.dart';
import 'package:my_farm_app/UI/Widgets/trendingListViewWidget.dart';

class DashBoard extends StatelessWidget {
  static const routeName = '/dashBoard';
  final DBRepo _dbRepo;
  DashBoard({DBRepo dbRepo}) : _dbRepo = dbRepo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              child: CarouselSliderWidget(),
            ),
            const SizedBox(height: 20),
            Container(
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: TrendingListViewWidget(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: ProductGridViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
