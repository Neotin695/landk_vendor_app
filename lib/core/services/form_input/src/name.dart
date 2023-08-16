import 'package:formz/formz.dart';

enum NameValidatorError { invalid }

class Name extends FormzInput<String, NameValidatorError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidatorError? validator(String value) {
    return value.isNotEmpty &&value.length > 5 && value.length < 30
        ? null
        : NameValidatorError.invalid;
  }
}
