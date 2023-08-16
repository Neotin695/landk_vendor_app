import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/model.dart';

abstract class _CategoryRepository {
  Future<List<Category>> fetchAllCategories();
}

class CategoryRepository implements _CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Category>> fetchAllCategories() async {
    return List<Category>.from(
      (await _firestore.collection('category').get()).docs.map(
            (e) => Category.fromMap(
              e.data(),
            ),
          ),
    );
  }
}
