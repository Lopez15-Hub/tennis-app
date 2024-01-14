import 'package:flutter_test/flutter_test.dart';
import 'package:tenis_app/core/helpers/date_helpers.dart';

void main() {
  group("0000_tests_function_formatDate", () {
    final date = DateTime.now();
    const expectedDate = "14/1/2024";
    test(
        "Pass date and return as String and expect this format: DD MM AAAA ",
        () => expect(
            formatDate(
              date,
            ),
            expectedDate));
  });
}
