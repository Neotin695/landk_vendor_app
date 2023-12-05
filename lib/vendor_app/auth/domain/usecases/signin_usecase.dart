import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';
import 'package:vendor_app/vendor_app/auth/domain/repo/auth_repo.dart';

class SignInUsecase {
  final AuthRepo _authRepo;

  SignInUsecase(this._authRepo);
  Future<UserEntity> call(String email, String password) async {
    return _authRepo.signin(email, password);
  }
}
