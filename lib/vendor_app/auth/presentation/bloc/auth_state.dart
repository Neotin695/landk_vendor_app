// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStates {
  initial,
  loading,
  failure,
  pickImg,
  pickImgSuccess,
  success,
}

class AuthState extends Equatable {
  final AuthStates status;
  final Email email;
  final String message;
  final Name name;
  final Phone phoneNum;
  final Password password;
  final bool isValid;
  final ConfirmedPassword passwordConfirm;
  const AuthState({
    this.status = AuthStates.initial,
    this.email = const Email.pure(),
    this.isValid = false,
    this.message = '',
    this.name = const Name.pure(),
    this.phoneNum = const Phone.pure(),
    this.password = const Password.pure(),
    this.passwordConfirm = const ConfirmedPassword.pure(),
  });

  @override
  List<Object> get props =>
      [email, name, phoneNum, password, passwordConfirm, isValid, status];

  AuthState copyWith({
    AuthStates? status,
    Email? email,
    bool? isValid,
    Name? name,
    String? message,
    Phone? phoneNum,
    Password? password,
    ConfirmedPassword? passwordConfirm,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      message: message ?? this.message,
      phoneNum: phoneNum ?? this.phoneNum,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    );
  }
}
