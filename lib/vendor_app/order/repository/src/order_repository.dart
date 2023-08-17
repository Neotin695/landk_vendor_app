// ignore: library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as fStore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor_app/models/customer.dart';
import 'package:vendor_app/models/delegate.dart';
import 'package:vendor_app/vendor_app/order/repository/src/models/model.dart';
import 'package:vendor_app/vendor_app/products/repository/product_repository.dart';

abstract class _OrderRepository {
  Future<void> acceptOrder(String id);
  Future<void> rejectOrder(String id);
  Future<Order> fetchOneOrder(String id);
  Future<Customer> fetchCustomer(String id);
  Future<Delegate> fetchDelegate(String id);
  Future<List<Product>> fetchAllProducts(List<String> ids);
  Stream<List<Order>> fetchAllOrder();
}

class OrderRepository implements _OrderRepository {
  final fStore.FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderRepository()
      : _firestore = fStore.FirebaseFirestore.instance,
        _auth = FirebaseAuth.instance;

  @override
  Future<void> acceptOrder(String id) async {
    try {
      await _firestore
          .collection('stores')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(id)
          .update({'acceptable': true});
    } catch (e) {
      print('acceptOrder: $e');
    }
  }

  @override
  Stream<List<Order>> fetchAllOrder() {
    try {
      return _firestore
          .collection('stores')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .snapshots()
          .map((event) {
        return List<Order>.from(event.docs.map((e) => Order.fromMap(e.data())));
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<Customer> fetchCustomer(String id) async {
    try {
      return Customer.fromMap(
          (await _firestore.collection('customers').doc(id).get()).data()!);
    } catch (e) {
      print('fetchCustomer: $e');
      return Customer.empty();
    }
  }

  @override
  Future<Delegate> fetchDelegate(String id) async {
    try {
      return Delegate.fromMap(
          (await _firestore.collection('delegates').doc(id).get()).data()!);
    } catch (e) {
      print('fetchDelegate: $e');
      return Delegate.empty();
    }
  }

  @override
  Future<Order> fetchOneOrder(String id) async {
    try {
      return Order.fromMap((await _firestore
              .collection('stores')
              .doc(_auth.currentUser!.uid)
              .collection('orders')
              .doc(id)
              .get())
          .data()!);
    } catch (e) {
      print('fetchOneOrder: $e');
      return Order.empty();
    }
  }

  @override
  Future<void> rejectOrder(String id) async {
    try {
      await _firestore
          .collection('stores')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(id)
          .delete();
    } catch (e) {
      print('rejectOrder: $e');
    }
  }

  @override
  Future<List<Product>> fetchAllProducts(List<String> ids) async {
    List<Product> products = [];
    try {
      for (var element in ids) {
        await _firestore
            .collection('products')
            .where('id', isEqualTo: element)
            .get()
            .then((value) {
          value.docs.map((e) {
            products.add(Product.fromMap(e.data()));
          });
        });
      }
      return products;
    } catch (e) {
      print('fetchAllProducts: $e');
      return [];
    }
  }
}
