import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_farm_app/Model/addProductCounter.dart';

part 'cartitem_counter_event.dart';
part 'cartitem_counter_state.dart';

class CartitemCounterBloc
    extends Bloc<CartItemCounterEvent, CartItemCounterState> {
  AddProductCounter myCounter = AddProductCounter();
  CartitemCounterBloc() : super(CartItemCounterInitial());

  @override
  CartItemCounterState get initialState => CartItemCounterInitial();

  @override
  Stream<CartItemCounterState> mapEventToState(
    CartItemCounterEvent event,
  ) async* {
    if (event is IncreamentCounter) {
      yield CartItemCounterInitial();

      event.counter = event.counter + 1;
      myCounter.setCounter = event.counter;

      yield CartItemCounterLoaded(event.counter);
    }
    if (event is DecreamentCounter) {
      event.counter = event.counter - 1;
      myCounter.setCounter = event.counter;
      yield CartItemCounterLoaded(event.counter);
    }
  }
}
