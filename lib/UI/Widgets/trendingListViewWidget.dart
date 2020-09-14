import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/TrendingBloc/trending_bloc.dart';

class TrendingListViewWidget extends StatefulWidget {
  @override
  _TrendingListViewWidgetState createState() => _TrendingListViewWidgetState();
}

class _TrendingListViewWidgetState extends State<TrendingListViewWidget> {
  TrendingBloc _trendingBloc;

  // DBRepo _dbRepo = DBRepo();

  @override
  void initState() {
    _trendingBloc = BlocProvider.of<TrendingBloc>(context);
    print('initstate');
    _trendingBloc.add(GetTrendingImages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingBloc, TrendingState>(
      builder: (context, state) {
        if (state is TrendingimagesLoading) {
          return Container();
        }
        if (state is TrendingimagesLoaded) {
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
                return Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int itemIndex) => Card(
                      child: Container(
                        // height: 100,
                        width: 160.0,
                        child: Image.network(
                          snapshot.data.documents[itemIndex].data['imageUrl'],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
