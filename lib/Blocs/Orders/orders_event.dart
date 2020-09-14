part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class PutOrder extends OrdersEvent {
  AsyncSnapshot<dynamic> order;

  PutOrder(this.order);
}
