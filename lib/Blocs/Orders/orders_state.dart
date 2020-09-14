part of 'orders_bloc.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final Future result;

  OrdersLoaded(this.result);
}

class OrdersError extends OrdersState {
  final String result;

  OrdersError(this.result);
}
