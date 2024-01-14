import 'package:bloc/bloc.dart';

class FormValuesCubit extends Cubit<Map<String, dynamic>> {
  FormValuesCubit() : super({});

  capture<Data>(String key, Data data) {
    final updatedValues = {...state, key: data};
    emit(updatedValues);
  }

  reset({fields}) {
    if (fields != null) {
      emit({...state, ...fields});
    } else {
      emit({});
    }
  }
}
