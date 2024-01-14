import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/presentation/widgets/app/appbar_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/custom_buttom_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/input_group_widget.dart';

class CreateReservation extends StatelessWidget {
  const CreateReservation({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);
    final formValuesCubit = BlocProvider.of<FormValuesCubit>(context);
    handleSubmit() {
      if (formKey.currentState!.validate()) {
        reservationsBloc.add(CreateReservationRequested(formValuesCubit.state));
        formValuesCubit.reset();
        formKey.currentState!.reset();
        Navigator.pop(context);
      }
    }

    formValuesCubit.capture("court", "default");
    formValuesCubit.capture("dateOfReservation", "");
    return Scaffold(
      appBar: CustomAppbarWidget(
          title: "Reservar",
          leading: IconButton(
              onPressed: () {
                reservationsBloc.add(ReadReservationsRequested());
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(key: formKey, child: const InputGroup()),
            BlocBuilder<ReservationsBloc, ReservationsState>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: state is ReservationLimitExceeded ||
                          formValuesCubit.state["court"] == "default"
                      ? null
                      : () => handleSubmit(),
                  formKey: formKey,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
