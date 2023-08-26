// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/services/cache/cache.dart';
import '../../../store/repository/src/models/store.dart';
import 'models/models.dart';

abstract class _AuthenticationRepository {
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> createStore(
      {required Store store,
      required String password,
      required String confirmPassword});
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository implements _AuthenticationRepository {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final CacheClient _cacheClient;
  AuthenticationRepository({
    auth.FirebaseAuth? fAuth,
    CacheClient? cacheClient,
  })  : _auth = fAuth ?? auth.FirebaseAuth.instance,
        _cacheClient = cacheClient ?? CacheClient(),
        _firestore = FirebaseFirestore.instance,
        _storage = FirebaseStorage.instance;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const String userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      final User user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cacheClient.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cacheClient.read<User>(key: userCacheKey) ?? User.empty;
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> createStore(
      {required Store store,
      required String password,
      required String confirmPassword}) async {
    if (store == Store.empty()) {
      return;
    } else {
      await _signUpWithEmailAndPassowrd(
              email: store.onwer.email,
              password: password,
              confirmPassword: confirmPassword)
          .then((value) async {
        await _uploadImage(store.logoUrl, store.name).then((logo) async {
          await _uploadImage(store.coverUrl, store.name).then((cover) async {
            await _firestore
                .collection('stores')
                .doc(value.user!.uid)
                .set(store
                    .copyWith(
                        id: value.user!.uid,
                        logoUrl: logo,
                        coverUrl: cover,
                        active: false)
                    .toMap())
                .then((value) {});
          });
        });
      });
    }
  }

  Future<String> _uploadImage(String path, storeName) async {
    final file = File(path);
    final task = await _storage
        .ref(storeName)
        .child('${path.split('/').last}.png')
        .putFile(file);
    if (task.state == TaskState.success) {
      return await task.ref.getDownloadURL();
    } else {
      return '';
    }
  }

  Future<auth.UserCredential> _signUpWithEmailAndPassowrd(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}

extension on auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
