part of 'placeorder_bloc.dart';

abstract class PlaceorderState {}

class PlaceorderInitial extends PlaceorderState {}

class PlaceorderLoading extends PlaceorderState {}

class PlaceorderLoaded extends PlaceorderState {}

class PlaceorderError extends PlaceorderState {}

//

class CartItemCounterInitial extends PlaceorderState {}

class CartItemCounterLoaded extends PlaceorderState {
  final int counter;
  CartItemCounterLoaded(this.counter);
}
