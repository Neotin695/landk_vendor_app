import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor_app/vendor_app/auth/repository/authentication_repository.dart';
import 'package:vendor_app/vendor_app/store/repository/src/models/store.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(this._repository) : super(StoreInitial()) {
    on<FetchStoreEvent>(_fetchStore);
    on<DeleteStoreEvent>(_deleteStore);
    on<UpdateStoreEvent>(_updateStore);
    add(FetchStoreEvent());
  }
  final StoreRepository _repository;
  FutureOr<void> _updateStore(event, Emitter<StoreState> emit) {
    // TODO: implement event handler
  }

  FutureOr<void> _deleteStore(event, Emitter<StoreState> emit) {
    // TODO: implement event handler
  }

  FutureOr<void> _fetchStore(event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    await emit
        .forEach(_repository.fetchStore(FirebaseAuth.instance.currentUser!.uid),
            onData: (data) {
      return StoreLoaded(store: data);
    }, onError: (err, errr) {
      print(err);
      return StoreFailure(message: err.toString());
    });
  }
}
