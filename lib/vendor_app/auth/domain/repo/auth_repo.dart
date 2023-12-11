import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity> signin(String email, String password);
  Future<UserEntity> signup(UserEntity userEntity, String password);

  Future<void> forgotPassword(String email);
}
