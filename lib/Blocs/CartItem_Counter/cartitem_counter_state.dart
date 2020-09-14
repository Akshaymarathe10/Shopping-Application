part of 'cartitem_counter_bloc.dart';

abstract class CartItemCounterState {}

class CartItemCounterInitial extends CartItemCounterState {}

class CartItemCounterLoaded extends CartItemCounterState {
  final int counter;
  CartItemCounterLoaded(this.counter);
}
