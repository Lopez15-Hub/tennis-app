import 'package:flutter_test/flutter_test.dart';
import 'package:tenis_app/core/helpers/data_validators_helpers.dart';

void main() {
  String errorMessage = "Campo inválido";
  String successInput = "hola";
  String errorInput = "";
  group("0000_test_function_isNotEmpty", () {
    test(
        "Return null if the input is not empty",
        () => expect(
            valueIsNotEmpty(successInput, errorMessage: errorMessage), null));
    test(
        "Return errorMessage text if the input is empty",
        () => expect(valueIsNotEmpty(errorInput, errorMessage: errorMessage),
            errorMessage));
  });
  group("0001_test_function_notContains", () {
    errorMessage = "Campo inválido";
    successInput = "hola";
    const successPattern = "Juan";
    const errorPattern = "hola";
    test(
        "Return null if the input not contains the defined pattern",
        () => expect(
            notContains(successInput, successPattern,
                errorMessage: errorMessage),
            null));
    test(
        "Return errorMessage text if the input contains the word",
        () => expect(
            notContains(successInput, errorPattern, errorMessage: errorMessage),
            errorMessage));
  });
}
