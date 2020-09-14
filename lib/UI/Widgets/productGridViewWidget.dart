import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_farm_app/Blocs/ProductGridViewBloc/productgridview_bloc.dart';
import 'package:my_farm_app/UI/Widgets/ProductItemWidget.dart';

class ProductGridViewWidget extends StatefulWidget {
  @override
  _ProductGridViewWidgetState createState() => _ProductGridViewWidgetState();
}

class _ProductGridViewWidgetState extends State<ProductGridViewWidget> {
  ProductgridviewBloc _productgridviewBloc;

  @override
  void initState() {
    _productgridviewBloc = BlocProvider.of<ProductgridviewBloc>(context);
    _productgridviewBloc.add(GetProductGridView());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductgridviewBloc, ProductgridviewState>(
      builder: (context, state) {
        if (state is ProductgridviewError) {
          return Text(state.errorMsg);
        }
        if (state is ProductgridviewLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductgridviewLoaded) {
          Stream<QuerySnapshot> _productsStream = state.products;
          return StreamBuilder(
            stream: _productsStream,
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data.documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (ctx, i) {
                      return Card(
                        child: ProductItemWidget(
                          productSnapshot: snapshot.data.documents[i],
                        ),
                      );
                    },
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
