import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:vendor_app/core/services/category_repository/category_repository.dart';
import 'package:vendor_app/core/services/form_input/src/address.dart';
import 'package:vendor_app/core/services/form_input/src/name.dart';
import 'package:vendor_app/core/services/form_input/src/phone.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';
import 'package:vendor_app/models/address_info.dart';
import 'package:vendor_app/models/id_card.dart';
import 'package:vendor_app/vendor_app/maps/map_repository/map_repository.dart';

import '../../../../core/services/form_input/form_input.dart';
import '../../../maps/view/map_page.dart';
import '../../repository/authentication_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authenticationRepository)
      : _categoryRepository = CategoryRepository(),
        super(const AuthState());

  final AuthenticationRepository _authenticationRepository;
  final CategoryRepository _categoryRepository;

  final PageController controller = PageController();
  LocationData? locationData;

  Map<String, dynamic> placeDatals = {};
  List<Category> categories = [];
  String? logoPath;
  String? coverPath;
  String selectedCategory = '';
  Category category = Category.empty();

  Future<void> fetchAllCategories() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    categories = await _categoryRepository.fetchAllCategories();
    if (categories.isNotEmpty) {
      category = categories[0];
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      category = Category.empty();
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, errorMessage: 'loc'));
    locationData =
        await MapRepository().getCurrentLocation().then((event) async {
      if (event != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          event.latitude!,
          event.longitude!,
        );
        if (placemarks.isNotEmpty) {
          placeDatals = {
            'name': placemarks[0].subAdministrativeArea!,
            'street': placemarks[0].street!,
            'postalcode': placemarks[0].postalCode!,
          };
        }
      }
      return event;
    });

    if (locationData == null) {
      emit(state.copyWith(
          // ignore: use_build_context_synchronously
          errorMessage: trans(context).errorCurrentLocation,
          status: FormzSubmissionStatus.failure));
    }

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  Future<void> setLocationOnMap(BuildContext context) async {
    locationData = await Navigator.push<LocationData>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPage(
          mapRepository: MapRepository(),
          state: 'locate',
        ),
      ),
    ).then((value) async {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      return value;
    });

    if (locationData == null) {
      emit(state.copyWith(
          errorMessage: trans(context).errorMapLocation,
          status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> createStore(BuildContext context) async {
    if (logoPath != null && coverPath != null && locationData != null) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress, errorMessage: 'hh'));
      await _authenticationRepository
          .createStore(
            store: _initStore(),
            password: state.password.value,
            confirmPassword: state.confirmedPassword.value,
          )
          .then((value) {});
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Store _initStore() {
    return Store(
        id: '',
        onwer: _initOnwer(),
        active: false,
        name: state.name.value,
        category: category.id,
        logoUrl: logoPath!,
        coverUrl: coverPath!,
        acceptable: false,
        addressInfo: _initAddress(),
        reviews: const []);
  }

  AddressInfo _initAddress() {
    return AddressInfo(
        longitude: locationData!.longitude!,
        latitude: locationData!.latitude!,
        specialMarque: state.address.value);
  }

  Onwer _initOnwer() {
    final firstName = state.fullName.value.split(' ').first;
    final middleName = state.fullName.value.split(' ').length > 1
        ? state.fullName.value.split(' ')[1]
        : '';
    final lastName = state.fullName.value.split(' ').last;
    return Onwer(
        userName: state.fullName.value,
        phoneNum: state.phone.value,
        email: state.email.value,
        idCard: IdCard(
            firstName: firstName,
            lastName: lastName,
            nationalNum: '',
            middleName: middleName));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
        ]),
      ),
    );
  }

  void emailChangedSignUp(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          name: name,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            name,
            state.address,
            state.phone
          ]),
        ),
      );
    }
  }

  void addressChanged(String value) {
    final address = Address.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          address: address,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            state.name,
            address,
            state.phone
          ]),
        ),
      );
    }
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          phone: phone,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            state.name,
            state.address,
            phone
          ]),
        ),
      );
    }
  }

  void fullNameChanged(String value) {
    final fullName = Name.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          fullName: fullName,
          isValid: Formz.validate([
            state.email,
            state.password,
            fullName,
            state.name,
            state.address,
            state.phone
          ]),
        ),
      );
    }
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
        ]),
      ),
    );
  }

  void passwordChangedSignUp(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final conPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);

    emit(
      state.copyWith(
        confirmedPassword: conPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          conPassword,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
