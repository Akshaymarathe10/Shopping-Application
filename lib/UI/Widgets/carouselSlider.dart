import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/CarouselImagesBloc/carouselimages_bloc.dart';

class CarouselSliderWidget extends StatefulWidget {
  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  CarouselimagesBloc _carouselimagesBloc;

  // DBRepo _dbRepo = DBRepo();

  @override
  void initState() {
    _carouselimagesBloc = BlocProvider.of<CarouselimagesBloc>(context);
    print('initstate');
    _carouselimagesBloc.add(GetCarouselImages());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselimagesBloc, CarouselimagesState>(
      builder: (context, state) {
        if (state is CarouselimagesError) {
          return Text(state.errorMsg);
        }
        if (state is CarouselimagesLoading) {
          return CircularProgressIndicator();
        }
        if (state is CarouselimagesLoaded) {
          Stream<QuerySnapshot> productStream = state.products;
          return StreamBuilder(
            stream: productStream,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                );
              } else {
                return CarouselSlider.builder(
                  options: CarouselOptions(height: 200),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(
                      snapshot.data.documents[itemIndex].data['imageUrl'],
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return Text('previewing images');
        }
      },
    );
  }
}
