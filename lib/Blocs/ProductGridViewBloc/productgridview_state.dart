part of 'productgridview_bloc.dart';

abstract class ProductgridviewState {}

class ProductgridviewInitial extends ProductgridviewState {}

class ProductgridviewLoading extends ProductgridviewState {}

class ProductgridviewLoaded extends ProductgridviewState {
  final Stream<QuerySnapshot> products;

  ProductgridviewLoaded(this.products);
}

class ProductgridviewError extends ProductgridviewState {
  final String errorMsg;

  ProductgridviewError(this.errorMsg);
}
