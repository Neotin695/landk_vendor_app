import 'package:formz/formz.dart';

enum AddressValidatorError { invalid }

class Address extends FormzInput<String, AddressValidatorError> {
  const Address.pure() : super.pure('');

  const Address.dirty([super.value = '']) : super.dirty();

  @override
  AddressValidatorError? validator(String value) {
    return value.isNotEmpty && value.length > 20 && value.length < 100
        ? null
        : AddressValidatorError.invalid;
  }
}
