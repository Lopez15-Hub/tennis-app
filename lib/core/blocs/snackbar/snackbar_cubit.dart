import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'snackbar_state.dart';

class SnackbarCubit extends Cubit<SnackbarState> {
  SnackbarCubit() : super(SnackbarInitial());

  _createSnackbar(BuildContext context, String label, String type) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    switch (type) {
      case "success":
        messenger.showSnackBar(SnackBar(
          content: Text(label),
          showCloseIcon: true,
          backgroundColor: Colors.green,
        ));
      default:
        messenger.showSnackBar(SnackBar(
          content: Text(label),
          backgroundColor: Colors.red,
        ));
    }
  }

  success(BuildContext context, String label) =>
      _createSnackbar(context, label, "success");
  error(BuildContext context, String label) =>
      _createSnackbar(context, label, "error");
}
