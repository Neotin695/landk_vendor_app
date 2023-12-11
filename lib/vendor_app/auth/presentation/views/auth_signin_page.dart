import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/services/injection/injection_container.dart';
import 'package:vendor_app/core/services/scaffold_key.dart';
import 'package:vendor_app/vendor_app/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/tools/tools_widget.dart';
import 'auth_signin_view.dart';

class AuthSignInPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: AuthSignInPage());
  const AuthSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldAuth,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 25.w,
        leading: dropDownButtonLang(context),
      ),
      body: BlocProvider<AuthBloc>(
        create: (context) => sl(),
        child: const AuthSignInView(),
      ),
    );
  }
}
