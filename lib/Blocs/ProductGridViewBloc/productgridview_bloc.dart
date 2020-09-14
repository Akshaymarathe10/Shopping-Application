import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_farm_app/Repository/db_repo.dart';

part 'productgridview_event.dart';
part 'productgridview_state.dart';

class ProductgridviewBloc
    extends Bloc<ProductgridviewEvent, ProductgridviewState> {
  final DBRepo _dbRepo;
  ProductgridviewBloc({@required DBRepo dbRepo})
      : _dbRepo = dbRepo,
        super(null);

  @override
  ProductgridviewState get initialState => ProductgridviewInitial();
  //
  @override
  Stream<ProductgridviewState> mapEventToState(
    ProductgridviewEvent event,
  ) async* {
    if (event is GetProductGridView) {
      yield ProductgridviewLoading();
      Stream<QuerySnapshot> _gridProducts = _dbRepo.getGridImages();
      if (_gridProducts != null) {
        yield ProductgridviewLoaded(_gridProducts);
      } else {
        yield ProductgridviewError('Cant fetch the Products');
      }
    }
  }
}
