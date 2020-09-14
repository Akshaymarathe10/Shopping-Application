import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Repository/db_repo.dart';

part 'carouselimages_event.dart';
part 'carouselimages_state.dart';

class CarouselimagesBloc
    extends Bloc<CarouselimagesEvent, CarouselimagesState> {
  final DBRepo _dbRepo;
  CarouselimagesBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);

  @override
  CarouselimagesState get initialState => CarouselimagesInitial();

  @override
  Stream<CarouselimagesState> mapEventToState(
    CarouselimagesEvent event,
  ) async* {
    if (event is GetCarouselImages) {
      yield CarouselimagesLoading();
      Stream<QuerySnapshot> _products = _dbRepo.getCarouselImages();

      if (_products != null) {
        yield CarouselimagesLoaded(products: _products);
      } else {
        yield CarouselimagesError(errorMsg: "Can't preview images");
      }
    }
  }
}
