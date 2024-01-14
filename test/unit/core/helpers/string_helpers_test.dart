import 'package:flutter_test/flutter_test.dart';
import 'package:tenis_app/core/helpers/string_helpers.dart';

void main() {
  group("0000_tests_function_split", () {
    const input = "hola como estas";
    const expectedInput = "hola";
    const pattern = " ";
    test("Split a text and get the first position",
        () => expect(split(input, pattern), expectedInput));
  });
  group("0001_tests_function_valueIsNotEmpty", () {
    const input = "lorem ipsum";

    test("if value is not empty, then return true.",
        () => expect(valueNotEmpty(input), true));
  });
}
