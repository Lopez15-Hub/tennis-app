import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';

void main() {
  group("0000_test_bloc_FormValuesCubit", () {
    
    late FormValuesCubit formValuesCubit;
    setUp(() {
      formValuesCubit = FormValuesCubit();
    });

    test('initial state is {}', () {
      
      expect(formValuesCubit.state, {});
    });
    blocTest(
      'Update values map with a new property ',
      build: () => formValuesCubit,
      act: (cubit) => cubit.capture("sampleText", "lorem ipsum"),
      expect: () => [
        {"sampleText": "lorem ipsum"}
      ],
    );
  });
}
