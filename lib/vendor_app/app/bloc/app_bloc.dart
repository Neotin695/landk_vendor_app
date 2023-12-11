import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor_app/core/services/shared_values.dart';
import 'package:vendor_app/vendor_app/auth/data/model/user_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unauthenticated()) {
    on<AppUserChanged>(_userChanged);
    on<AppLogoutRequest>(_appLogoutRequest);
    add(AppUserChanged());
  }

  FutureOr<void> _appLogoutRequest(event, emit) {}

  FutureOr<void> _userChanged(AppUserChanged event, Emitter emit) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        final user = UserModel.fromMap(value.data()!);
        print(user);
        userData.setIfChanged(user.toMap());
        userData.save();
        emit(const AppState.authenticated());
      }
    });
  }
}
