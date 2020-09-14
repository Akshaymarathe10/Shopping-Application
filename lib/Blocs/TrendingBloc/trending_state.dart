part of 'trending_bloc.dart';

abstract class TrendingState {}

class TrendingimagesInitial extends TrendingState {}

class TrendingimagesLoading extends TrendingState {}

class TrendingimagesLoaded extends TrendingState {
  final Stream<QuerySnapshot> products;
  TrendingimagesLoaded({this.products});
}

class TrendingimagesError extends TrendingState {
  final String errorMsg;

  TrendingimagesError({this.errorMsg});
}
