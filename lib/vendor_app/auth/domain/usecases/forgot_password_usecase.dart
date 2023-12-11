import 'package:vendor_app/vendor_app/auth/domain/repo/auth_repo.dart';

class ForgotPasswordUsecase {
  final AuthRepo _authRepo;

  ForgotPasswordUsecase(this._authRepo);

  Future<void> call(String email) {
    return _authRepo.forgotPassword(email);
  }
}
