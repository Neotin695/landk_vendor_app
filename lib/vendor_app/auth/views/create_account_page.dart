import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../repository/src/authentication_repository.dart';
import 'create_account_view.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key, required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthCubit(authenticationRepository),
        child: const CreateAccountView(),
      ),
    );
  }
}
