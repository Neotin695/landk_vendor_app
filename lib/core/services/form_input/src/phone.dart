import 'package:formz/formz.dart';

enum PhoneValidatorError { invalid }

class Phone extends FormzInput<String, PhoneValidatorError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidatorError? validator(String value) {
    return value.trim().length > 10 && value.trim().length <= 12
        ? null
        : PhoneValidatorError.invalid;
  }
}
