import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'popup_state.dart';

class PopupCubit extends Cubit<PopupState> {
  PopupCubit() : super(PopupInitial());

  show(BuildContext context, Widget widget) =>
      showDialog(context: context, builder: (context) => widget);
}
