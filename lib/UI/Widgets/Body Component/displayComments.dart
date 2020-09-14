import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayComments extends StatelessWidget {
  final DocumentSnapshot product;

  const DisplayComments({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final docId = product.documentID;
    Stream<QuerySnapshot> dataVar = Firestore.instance
        .collection('gridImages')
        .document(docId)
        .collection('productDetails')
        .snapshots();
    return Container(
      child: StreamBuilder(
        stream: dataVar,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '${snapshot.data.documents[i].data['details']}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
