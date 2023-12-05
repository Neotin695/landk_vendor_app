import 'package:vendor_app/vendor_app/auth/data/datasource/remote_firebase.dart';
import 'package:vendor_app/vendor_app/auth/data/model/user_model.dart';
import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';
import 'package:vendor_app/vendor_app/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteFirebase _remoteFirebase;

  AuthRepoImpl(this._remoteFirebase);

  @override
  Future<UserEntity> signin(String email, String password) async {
    try {
      final user = await _remoteFirebase.signin(email, password);
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<UserEntity> signup(UserEntity userEntity, String password) async {
    try {
      final user =
          await _remoteFirebase.signup(UserModel.toModel(userEntity), password);
      return user;
    } catch (e) {
      throw e;
    }
  }
}
