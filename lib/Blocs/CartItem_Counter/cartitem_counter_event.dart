part of 'cartitem_counter_bloc.dart';

abstract class CartItemCounterEvent {}

class IncreamentCounter extends CartItemCounterEvent {
  int counter;

  IncreamentCounter(this.counter);
}

class DecreamentCounter extends CartItemCounterEvent {
  int counter;
  DecreamentCounter(this.counter);
}
