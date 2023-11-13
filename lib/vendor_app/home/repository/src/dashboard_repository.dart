import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor_app/models/review.dart';
import 'package:vendor_app/vendor_app/store/repository/src/models/store.dart';

import 'model/model.dart';

abstract class _DashboardRepository {
  Future<Analysis> analyseData();
}

class DashboardRepository implements _DashboardRepository {
  final FirebaseFirestore _firestore;

  DashboardRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<Analysis> analyseData() async {
    double reviewsCount = 0;
    int products = 0;
    int orders = 0;

    await _firestore
        .collection('stores')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists && value.data() != null) {
        final store = Store.fromMap(value.data()!);
        await _firestore
            .collection('reviews')
            .where('id', arrayContains: store.reviews)
            .get()
            .then((value) async {
          final reviews = List<Review>.from(
              value.docs.map((e) => Review.fromMap(e.data())));

          for (var element in reviews) {
            reviewsCount += element.rate;
          }
          await _firestore
              .collection('products')
              .where('storeId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) async {
            products = value.docs.length;

            await _firestore.collection('orders').get().then((value) async {
              orders = value.docs.length;
            });
          });
        });
      }
    });
    print('pro: $products');
    return Analysis(
      reviewCount: reviewsCount,
      productsCount: products,
      ordersCount: orders,
    );
  }
}
