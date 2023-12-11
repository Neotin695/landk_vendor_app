import 'package:get_it/get_it.dart';
import 'package:vendor_app/vendor_app/auth/data/datasource/remote_firebase.dart';
import 'package:vendor_app/vendor_app/auth/data/repo/auth_repo_impl.dart';
import 'package:vendor_app/vendor_app/auth/domain/repo/auth_repo.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/signin_usecase.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/signup_usecase.dart';
import 'package:vendor_app/vendor_app/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Auth
  sl.registerSingleton<RemoteFirebase>(RemoteFirebase());

  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl()));

  sl.registerSingleton<SignInUsecase>(SignInUsecase(sl()));

  sl.registerSingleton<SignUpUsecase>(SignUpUsecase(sl()));

  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase(sl()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl()));
  // Auth End
}
