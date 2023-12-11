import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_value/shared_value.dart';
import 'package:vendor_app/core/services/injection/injection_container.dart';
import 'package:vendor_app/vendor_app/app/app.dart';

import 'core/services/common.dart';
import 'core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Common.prefs = await SharedPreferences.getInstance();

  await initializeDependencies();

  runApp(SharedValue.wrapApp(const App()));
}
