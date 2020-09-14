import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Repository/db_repo.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final DBRepo _dbRepo;
  StreamSubscription _OrderSubscription;
  OrdersBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);
  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is PutOrder) {
      yield OrdersLoading();
      Future result = _dbRepo.userOrders(event.order);
      if (result != null) {
        yield OrdersLoaded(result);
      } else {
        yield OrdersError('Order not placed');
      }
    }
  }

  @override
  Future<void> close() {
    _OrderSubscription?.cancel();
    return super.close();
  }
}
