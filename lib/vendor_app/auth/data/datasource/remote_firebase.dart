import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vendor_app/core/constances/error_code_const.dart';
import 'package:vendor_app/core/services/image_helper/image_uploader.dart';
import 'package:vendor_app/vendor_app/auth/data/model/user_model.dart';

abstract class BaseRemoteFirebase {
  Future<UserModel> signin(String email, String password);
  Future<UserModel> signup(UserModel userModel, String password);
  Future<void> forgotPassword(String email);
}

class RemoteFirebase with ImageUploader implements BaseRemoteFirebase {
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _auth;
  late final FirebaseStorage _storage;

  RemoteFirebase()
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance,
        _storage = FirebaseStorage.instance;

  @override
  Future<UserModel> signin(String email, String password) async {
    try {
      final userAuth = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final snapshot =
          await _firestore.collection('users').doc(userAuth.user!.uid).get();

      if (!snapshot.exists) {
        throw ErrorCode.noUserData;
      } else {
        final user = UserModel.fromMap(snapshot.data()!);

        if (user.role != 'vendor') {
          throw ErrorCode.userNotAllowed;
        } else if (!user.active) {
          throw ErrorCode.accountBanned;
        } else {
          return user;
        }
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  @override
  Future<UserModel> signup(UserModel userModel, String password) async {
    UserModel user = UserModel.empty;
    print(userModel);
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: userModel.email, password: password)
          .then((userAuth) async {
        await uploadSingleImg<String>(_storage, 'users', userModel.photoUrl.url)
            .then((value) async {
          await _firestore
              .collection('users')
              .doc(userAuth.user!.uid)
              .set(UserModel.toModel(userModel.copyWith(
                      photoUrl: value, id: userAuth.user!.uid))
                  .toMap())
              .then((_) {
            user = UserModel.toModel(userModel.copyWith(photoUrl: value));
          });
        });
      });

      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e.code;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
}
