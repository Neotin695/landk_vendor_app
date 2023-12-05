import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/vendor_app/app/app.dart';

import 'core/services/common.dart';
import 'core/services/firebase_options.dart';
import 'vendor_app/auth/repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Common.prefs = await SharedPreferences.getInstance();

  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
