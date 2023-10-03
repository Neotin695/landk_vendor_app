import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/vendor_app/auth/repository/authentication_repository.dart';
import 'package:vendor_app/vendor_app/store/view/store_view.dart';

import '../bloc/store_bloc.dart';

class StorePage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: StorePage(
        repository: StoreRepository(),
      ));
  const StorePage({super.key, required this.repository});

  final StoreRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (context) => StoreBloc(repository),
        child: const StoreView(),
      ),
    );
  }
}
