part of 'ordersummery_bloc.dart';

abstract class OrdersummeryState {}

class OrdersummeryInitial extends OrdersummeryState {}

class OrdersummeryLoading extends OrdersummeryState {}

class OrdersummeryLoaded extends OrdersummeryState {
  final Future<QuerySnapshot> orderSummery;

  OrdersummeryLoaded(this.orderSummery);
}

class OrdersummeryError extends OrdersummeryState {
  final String errorMsg;
  OrdersummeryError(this.errorMsg);
}
