part of 'carouselimages_bloc.dart';

abstract class CarouselimagesState {}

class CarouselimagesInitial extends CarouselimagesState {}

class CarouselimagesLoading extends CarouselimagesState {}

class CarouselimagesLoaded extends CarouselimagesState {
  final Stream<QuerySnapshot> products;
  CarouselimagesLoaded({this.products});
}

class CarouselimagesError extends CarouselimagesState {
  final String errorMsg;

  CarouselimagesError({this.errorMsg});
}
