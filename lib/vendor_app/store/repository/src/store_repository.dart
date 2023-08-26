import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'models/store.dart';

abstract class _StoreRepository {
  Future<void> updateStore(Store store);

  Future<void> deleteStore(String id);

  Stream<Store> fetchStore(String id);
}

class StoreRepository extends _StoreRepository {
  final FirebaseFirestore _store;
  final FirebaseStorage _storeage;

  StoreRepository()
      : _store = FirebaseFirestore.instance,
        _storeage = FirebaseStorage.instance;

  @override
  Future<void> deleteStore(String id) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Stream<Store> fetchStore(String id) {
    // TODO: implement fetchStore
    throw UnimplementedError();
  }

  @override
  Future<void> updateStore(Store store) {
    // TODO: implement updateStore
    throw UnimplementedError();
  }
}
