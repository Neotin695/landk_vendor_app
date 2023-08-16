import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../auth/repository/authentication_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<_AppUserChanged>(_userChanged);
    on<AppLogoutRequest>(_appLogoutRequest);
    _streamSubscription = authenticationRepository.user.listen((user) {
      add(_AppUserChanged(user: user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _streamSubscription;
  FutureOr<void> _appLogoutRequest(event, emit) {
    unawaited(_authenticationRepository.logOut());
  }

  FutureOr<void> _userChanged(_AppUserChanged event, emit) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
