import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Repository/db_repo.dart';

part 'ordersummery_event.dart';
part 'ordersummery_state.dart';

class OrdersummeryBloc extends Bloc<OrdersummeryEvent, OrdersummeryState> {
  final DBRepo _dbRepo;

  OrdersummeryBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);

  @override
  OrdersummeryState get initialState => OrdersummeryInitial();

  @override
  Stream<OrdersummeryState> mapEventToState(
    OrdersummeryEvent event,
  ) async* {
    if (event is GetOrderSummery) {
      yield OrdersummeryLoading();
      Future<QuerySnapshot> _orderSummery = _dbRepo.fetchOrderSummery();
      if (_orderSummery != null) {
        yield OrdersummeryLoaded(_orderSummery);
      } else {
        yield OrdersummeryError("Something went wrong");
      }
    }
  }
}
