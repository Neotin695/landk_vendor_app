import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/core/services/form_input/form_input.dart';
import 'package:vendor_app/core/services/form_input/src/name.dart';
import 'package:vendor_app/core/services/form_input/src/phone.dart';
import 'package:vendor_app/core/services/image_helper/image_picker_mixin.dart';
import 'package:vendor_app/core/services/shared_values.dart';
import 'package:vendor_app/models/bank_model.dart';
import 'package:vendor_app/models/img_model.dart';
import 'package:vendor_app/models/rental_model.dart';
import 'package:vendor_app/vendor_app/auth/domain/entities/user_entity.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/signin_usecase.dart';
import 'package:vendor_app/vendor_app/auth/domain/usecases/signup_usecase.dart';

import '../../data/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with PickMediaMixin {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  // variables
  File photoPath = File('');

  AuthBloc(
      this._signInUsecase, this._signUpUsecase, this._forgotPasswordUsecase)
      : super(const AuthState(status: AuthStates.initial)) {
    on<EmailChangeEvent>(_emailChange);
    on<PasswordChangeEvent>(_passwordChange);
    on<EmailChangeSignInEvent>(_emailChangeSignIn);
    on<PasswordChangeSignInEvent>(_passwordChangeSignIn);
    on<PasswordConfirmChangeEvent>(_passwordConfirmChange);
    on<PhoneNumChangeEvent>(_phoneNumChange);
    on<NameChangeEvent>(_nameChange);
    on<ForgotPasswordEvent>(_forgotPassword);
    on<PickPhoto>(_pickPhoto);
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<EmailChangeForgotEvent>(_emailChangeForgot);
  }

  FutureOr<void> _pickPhoto(PickPhoto event, emit) async {
    emit(state.copyWith(status: AuthStates.pickImg));
    final result = await pickSingleImage(event.imageSource);
    photoPath = File(result);
    emit(state.copyWith(status: AuthStates.pickImgSuccess));
  }

  FutureOr<void> _emailChangeForgot(EmailChangeForgotEvent event, emit) {
    final email = Email.dirty(event.value);
    emit(state.copyWith(
        status: AuthStates.success,
        email: email,
        isValid: Formz.validate([
          email,
        ])));
  }

  FutureOr<void> _signUp(event, emit) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: AuthStates.loading));
    try {
      final user = await _signUpUsecase.call(
        UserEntity(
          id: '',
          fcmToken: '',
          firstName: state.name.value.split(' ').first,
          active: false,
          isActive: false,
          lastName: state.name.value.split(' ').last,
          email: state.email.value,
          photoUrl: ImgModel(url: photoPath.path, id: ''),
          role: 'vendor',
          lastOnline: DateTime.now().toString(),
          settings: const Settings(),
          bankDetails: BankModel.empty(),
          rental: Rental.empty(),
          phonNum: state.phoneNum.value,
          walletAmount: 0,
        ),
        state.password.value,
      );

      if (user == UserEntity.empty()) {
        emit(state.copyWith(
            status: AuthStates.failure,
            message: 'unable to sign up currently try again later'));
      } else {
        userData.setIfChanged(UserModel.toModel(user).toMap());
        userData.save();
        emit(state.copyWith(status: AuthStates.success));
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: AuthStates.failure));
    }
  }

  FutureOr<void> _signIn(event, emit) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: AuthStates.loading));
    try {
      final user =
          await _signInUsecase.call(state.email.value, state.password.value);

      if (user == UserEntity.empty()) {
        emit(state.copyWith(
            status: AuthStates.failure,
            message: 'unable to sign in currently try again later'));
      } else {
        userData.setIfChanged(UserModel.toModel(user).toMap());
        userData.save();
           emit(state.copyWith(status: AuthStates.success));
      }
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(status: AuthStates.failure, message: e.toString()));
    }
  }

  FutureOr<void> _forgotPassword(event, emit) async {
    emit(state.copyWith(status: AuthStates.loading));
    try {
      await _forgotPasswordUsecase.call(state.email.value);
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(status: AuthStates.success));
    }
  }

  FutureOr<void> _nameChange(NameChangeEvent event, emit) {
    final name = Name.dirty(event.value);
    print(Formz.validate(
      [
        state.password,
        state.passwordConfirm,
        state.phoneNum,
        name,
        state.email,
      ],
    ));
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(
          [
            state.password,
            state.passwordConfirm,
            state.phoneNum,
            name,
            state.email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _phoneNumChange(PhoneNumChangeEvent event, emit) {
    final phoneNum = Phone.dirty(event.value);
    emit(
      state.copyWith(
        phoneNum: phoneNum,
        isValid: Formz.validate(
          [
            state.password,
            state.passwordConfirm,
            phoneNum,
            state.name,
            state.email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _passwordConfirmChange(
      PasswordConfirmChangeEvent event, emit) {
    final confirmPassword = ConfirmedPassword.dirty(
        password: state.password.value, value: event.value);
    emit(
      state.copyWith(
        passwordConfirm: confirmPassword,
        isValid: Formz.validate(
          [
            state.password,
            confirmPassword,
            state.phoneNum,
            state.name,
            state.email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _passwordChange(PasswordChangeEvent event, emit) {
    final password = Password.dirty(event.value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [
            password,
            state.passwordConfirm,
            state.phoneNum,
            state.name,
            state.email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _emailChange(EmailChangeEvent event, emit) {
    final email = Email.dirty(event.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            state.password,
            state.passwordConfirm,
            state.phoneNum,
            state.name,
            email,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _passwordChangeSignIn(PasswordChangeSignInEvent event, emit) {
    final password = Password.dirty(event.value);
    print('test: ${Formz.validate([password, state.email])}');
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [
            state.email,
            password,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _emailChangeSignIn(EmailChangeSignInEvent event, emit) {
    final email = Email.dirty(event.value);
    print('test: ${Formz.validate([email, state.password])}');
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            email,
            state.password,
          ],
        ),
      ),
    );
  }
}
