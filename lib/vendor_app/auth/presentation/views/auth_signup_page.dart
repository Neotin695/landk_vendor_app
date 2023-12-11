import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/core/services/injection/injection_container.dart';
import 'package:vendor_app/vendor_app/auth/presentation/bloc/auth_bloc.dart';

import 'auth_signup_view.dart';

class AuthSignUpPage extends StatelessWidget {
  const AuthSignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: const AuthSignUpView(),
    );
  }
}
