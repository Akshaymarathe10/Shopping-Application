// import './constants.dart';
// import 'package:flutter/material.dart';
// import 'package:my_farm_app/UI/Screens/dashBoard.dart';
// import 'package:my_farm_app/Repository/Authentication/authentication_repo.dart';

// class Router {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       case '/dashBoard':
//         if (args is AuthenticationRepo)
//           return MaterialPageRoute(
//             builder: (_) => DashBoard(
//               dbRepo: args,
//             ),
//           );
//         break;
//       default:
//         // If there is no such named route in the switch statement, e.g. /third
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: Center(
//           child: Text('ERROR'),
//         ),
//       );
//     });
//   }
// }
