import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../widgets/locate_location_widget.dart';
import '../widgets/onwer_info_widget.dart';
import '../widgets/store_info_widget.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late final AuthCubit cubit;
  @override
  void initState() {
    cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: cubit.controller,
          children: const [
            StoreInfoWidget(),
            OnwerInfoWidget(),
            LocateLocationWidget(),
          ],
        ),
      ),
    );
  }
}
