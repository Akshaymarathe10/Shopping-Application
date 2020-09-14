import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Model/addProductCounter.dart';
import 'package:my_farm_app/Repository/db_repo.dart';
part 'placeorder_event.dart';
part 'placeorder_state.dart';

class PlaceorderBloc extends Bloc<PlaceorderEvent, PlaceorderState> {
  final DBRepo _dbRepo;
  //
  AddProductCounter myCounter = AddProductCounter();
  PlaceorderBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);

  @override
  PlaceorderState get initialState => PlaceorderInitial();
  @override
  Stream<PlaceorderState> mapEventToState(
    PlaceorderEvent event,
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
    if (event is PutOrder) {
      _dbRepo.storeOrder(event.product, myCounter.getCounter);
    }
  }
}
