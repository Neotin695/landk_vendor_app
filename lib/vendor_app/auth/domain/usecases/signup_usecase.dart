import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';
import 'package:vendor_app/vendor_app/auth/domain/repo/auth_repo.dart';

class SignUpUsecase {
  final AuthRepo _authRepo;

  SignUpUsecase(this._authRepo);

  Future<UserEntity> call(UserEntity userEntity, String password) async {
    return _authRepo.signup(userEntity, password);
  }
}
