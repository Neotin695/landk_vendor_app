import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:vendor_app/vendor_app/products/repository/src/models/model.dart';

abstract class _ProductRepository {
  Future<Product> fetchOneProduct(String id);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<void> toggleActiveProduct(String id, bool state);
  Future<void> insertProduct(Product product);
  Stream<List<Product>> fetchAllProducts();
}

class ProductRepository implements _ProductRepository {
  final FirebaseFirestore _store;
  final FirebaseStorage _storage;

  ProductRepository()
      : _storage = FirebaseStorage.instance,
        _store = FirebaseFirestore.instance;

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await _store.collection('products').doc(id).delete();
    } catch (e) {
      print('deleteProduct: $e');
    }
  }

  @override
  Future<void> toggleActiveProduct(String id, bool state) async {
    try {
      await _store.collection('products').doc(id).update({'active': state});
    } catch (e) {
      print('disableProduct: $e');
    }
  }

  @override
  Stream<List<Product>> fetchAllProducts() {
    try {
      return _store
          .collection('products')
          .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((event) => List<Product>.from(
              event.docs.map((e) => Product.fromMap(e.data()))));
    } catch (e) {
      print('fetchAllProducts: $e');
      return Stream.error(e);
    }
  }

  @override
  Future<Product> fetchOneProduct(String id) async {
    try {
      return Product.fromMap(
          (await _store.collection('products').doc(id).get()).data()!);
    } catch (e) {
      print('fetchOneProduct: $e');
      return Product.empty();
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      await _store
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      print('updateProduct: $e');
    }
  }

  @override
  Future<void> insertProduct(Product product) async {
    String docId = _store.collection('products').doc().id;
    final String url = await uploadImage(product.coverUrl, docId);
    final List<String> urls = await uploadImages(product.images, docId);
    try {
      await _store.collection('products').doc(docId).set(
          product.copyWith(images: urls, coverUrl: url, id: docId).toMap());
    } catch (e) {
      print('insertProduct: $e');
    }
  }

  Future<String> uploadImage(String path, String id) async {
    final ref = _storage
        .ref('products')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(id)
        .child('${const Uuid().v4()}.png');
    try {
      final result = await ref.putFile(File(path));
      if (result.state == TaskState.success) {
        return await result.ref.getDownloadURL();
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<List<String>> uploadImages(List<String> paths, String id) async {
    List<String> urls = [];
    for (String path in paths) {
      final ref = _storage
          .ref('products')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(id)
          .child('${const Uuid().v4()}.png');
      try {
        final result = await ref.putFile(File(path));
        if (result.state == TaskState.success) {
          urls.add(await result.ref.getDownloadURL());
        } else {
          return [];
        }
      } catch (e) {
        return [];
      }
    }
    return urls;
  }
}
