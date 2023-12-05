// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.address = const Address.pure(),
    this.fullName = const Name.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage = '',
  });

  final Email email;
  final Password password;
  final Name name;
  final Name fullName;
  final Address address;
  final ConfirmedPassword confirmedPassword;
  final Phone phone;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String errorMessage;

  @override
  List<Object> get props {
    return [
      email,
      password,
      status,
      isValid,
      confirmedPassword,
      name,
      fullName,
      address,
      phone,
      errorMessage,
    ];
  }

  AuthState copyWith(
      {Email? email,
      Password? password,
      Name? name,
      Name? fullName,
      Address? address,
      Phone? phone,
      ConfirmedPassword? confirmedPassword,
      FormzSubmissionStatus? status,
      bool? isValid,
      String? errorMessage}) {
    return AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword?? this.confirmedPassword,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
