import 'package:flutter/material.dart';
import 'package:my_farm_app/Blocs/Orders/orders_bloc.dart';
import 'package:my_farm_app/Blocs/TrendingBloc/trending_bloc.dart';
import 'package:my_farm_app/Model/billArgument.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
import 'package:my_farm_app/UI/Screens/BillDetailsScreen.dart';
import 'package:my_farm_app/UI/Screens/orderSummery.dart';
import 'package:my_farm_app/UI/Screens/placeOrder.dart';
import 'package:my_farm_app/UI/Screens/productDetailScreen.dart';
import 'UI/Screens/dashBoard.dart';

import 'package:my_farm_app/UI/Screens/logInScreen.dart';
import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/Authentication/authentication_bloc.dart';
import 'package:my_farm_app/Blocs/CarouselImagesBloc/carouselimages_bloc.dart';
import 'package:my_farm_app/Blocs/ProductGridViewBloc/productgridview_bloc.dart';
import 'package:my_farm_app/Blocs/PlaceOrder/placeorder_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepo _authRepo = AuthenticationRepo();
  final DBRepo _dbRepo = DBRepo();
  // final int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == BillDetails.routeName) {
          final BillArgument args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return BillDetails(
                order: args.snapShot,
                totalPrice: args.totalPrice,
              );
            },
          );
        }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(authenticationRepo: _authRepo)
                  ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) =>
                CarouselimagesBloc(dbRepo: _dbRepo)..add(GetCarouselImages()),
          ),
          BlocProvider(
            create: (context) =>
                TrendingBloc(dbRepo: _dbRepo)..add(GetTrendingImages()),
          ),
          BlocProvider(
            create: (context) =>
                ProductgridviewBloc(dbRepo: _dbRepo)..add(GetProductGridView()),
          ),
          BlocProvider<PlaceorderBloc>(create: (context) {
            return PlaceorderBloc(dbRepo: _dbRepo)..add(InitialOrder());
          }),
          BlocProvider(
            create: (context) => OrdersBloc(dbRepo: _dbRepo),
          ),
        ],
        child: MyAppStartedPage(
          authenticatonRepo: _authRepo,
          dbRepo: _dbRepo,
        ),
      ),
      routes: {
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        DashBoard.routeName: (context) => DashBoard(),
        PlaceOrder.routeName: (context) => PlaceOrder(),
        OrderSummeryParent.routeName: (context) => OrderSummeryParent(),
        // BillDetailsScreen.routeName: (context) => BillDetailsScreen(),
      },
    );
  }
}

class MyAppStartedPage extends StatelessWidget {
  final AuthenticationRepo _authenticationRepo;
  final DBRepo _dbRepo;

  MyAppStartedPage({AuthenticationRepo authenticatonRepo, DBRepo dbRepo})
      : _authenticationRepo = authenticatonRepo,
        _dbRepo = dbRepo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is UnInitialized) {
          return Splash();
        }
        if (state is Authenticated) {
          return DashBoard(dbRepo: _dbRepo);
        }
        if (state is UnAuthenticated) {
          return LogInScreen(authenticationRepo: _authenticationRepo);
        } else {
          return Container();
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(12),
      body: Container(
        width: size.width,
        child: Center(
          child: Text(
            "Chill",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
