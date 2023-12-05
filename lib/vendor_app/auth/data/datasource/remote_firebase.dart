import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vendor_app/core/constances/error_code_const.dart';
import 'package:vendor_app/core/services/image_helper/image_uploader.dart';
import 'package:vendor_app/vendor_app/auth/data/model/user_model.dart';

abstract class BaseRemoteFirebase {
  Future<UserModel> signin(String email, String password);
  Future<UserModel> signup(UserModel userModel, String password);
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
    try {
      final userAuth = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      final imgUrl = await uploadSingleImg<String>(
          _storage, 'users', userModel.tempPathImg!);

      await _firestore
          .collection('users')
          .doc(userAuth.user!.uid)
          .set(UserModel.toModel(userModel.copyWith(photoUrl: imgUrl)).toMap());

      return UserModel.toModel(userModel.copyWith(photoUrl: imgUrl));
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }
}
