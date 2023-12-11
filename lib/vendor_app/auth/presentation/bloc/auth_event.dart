// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class PickPhoto extends AuthEvent {
  final ImageSource imageSource;
  const PickPhoto({
    required this.imageSource,
  });
}

class ForgotPasswordEvent extends AuthEvent {}

class EmailChangeEvent extends AuthEvent {
  final String value;
  const EmailChangeEvent({
    required this.value,
  });
}

class PasswordChangeEvent extends AuthEvent {
  final String value;
  const PasswordChangeEvent({
    required this.value,
  });
}

class EmailChangeSignInEvent extends AuthEvent {
  final String value;
  const EmailChangeSignInEvent({
    required this.value,
  });
}

class EmailChangeForgotEvent extends AuthEvent {
  final String value;
  const EmailChangeForgotEvent({
    required this.value,
  });
}

class PasswordChangeSignInEvent extends AuthEvent {
  final String value;
  const PasswordChangeSignInEvent({
    required this.value,
  });
}

class PasswordConfirmChangeEvent extends AuthEvent {
  final String value;
  const PasswordConfirmChangeEvent({
    required this.value,
  });
}

class NameChangeEvent extends AuthEvent {
  final String value;
  const NameChangeEvent({
    required this.value,
  });
}

class PhoneNumChangeEvent extends AuthEvent {
  final String value;
  const PhoneNumChangeEvent({
    required this.value,
  });
}
