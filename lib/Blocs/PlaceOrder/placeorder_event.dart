part of 'placeorder_bloc.dart';

abstract class PlaceorderEvent {}

//
class IncreamentCounter extends PlaceorderEvent {
  int counter;

  IncreamentCounter(this.counter);
}

class DecreamentCounter extends PlaceorderEvent {
  int counter;
  DecreamentCounter(this.counter);
}

class InitialOrder extends PlaceorderEvent {}

class PutOrder extends PlaceorderEvent {
  final DocumentSnapshot product;
  PutOrder(this.product);
}
