import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Repository/db_repo.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  final DBRepo _dbRepo;
  TrendingBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);
  @override
  TrendingState get initialState => TrendingimagesInitial();
  @override
  Stream<TrendingState> mapEventToState(
    TrendingEvent event,
  ) async* {
    if (event is GetTrendingImages) {
      yield TrendingimagesLoading();
      Stream<QuerySnapshot> _products = _dbRepo.getGridImages();

      if (_products != null) {
        yield TrendingimagesLoaded(products: _products);
      } else {
        yield TrendingimagesError(errorMsg: "Can't preview images");
      }
    }
  }
}
