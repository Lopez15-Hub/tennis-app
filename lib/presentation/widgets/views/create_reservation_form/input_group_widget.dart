import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis_app/core/blocs/form_values/form_values_cubit.dart';
import 'package:tenis_app/core/blocs/popup/popup_cubit.dart';
import 'package:tenis_app/core/blocs/reservations/reservations_bloc.dart';
import 'package:tenis_app/core/blocs/weather/weather_bloc.dart';
import 'package:tenis_app/core/helpers/data_validators_helpers.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/courts_dropdown_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/custom_datepicker_field_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/custom_form_field_widget.dart';
import 'package:tenis_app/presentation/widgets/views/create_reservation_form/weather_widget.dart';

class InputGroup extends StatelessWidget {
  const InputGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final formValuesCubit = BlocProvider.of<FormValuesCubit>(context);
    final popupCubit = BlocProvider.of<PopupCubit>(context);
    final reservationsBloc = BlocProvider.of<ReservationsBloc>(context);
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CourtsDropdown(
            validator: (court) => notContains(court.toString(), "default",
                errorMessage: "Elija la cancha")),
        BlocBuilder<FormValuesCubit, Map<String, dynamic>>(
          builder: (context, formValuesState) {
            return Column(
              children: [
                CustomFormField(
                    onChanged: (customer) =>
                        formValuesCubit.capture<String>("customer", customer),
                    label: "Nombre del solicitante(*)",
                    inputType: TextInputType.name,
                    hint: "Ingrese su nombre",
                    validator: (name) => valueIsNotEmpty(name,
                        errorMessage: "El nombre es requerido")),
                CustomDatePickerField(
                  formValuesCubit: formValuesCubit,
                  popupCubit: popupCubit,
                  reservationsBloc: reservationsBloc,
                  weatherBloc: weatherBloc,
                  enabled: formValuesState["court"] != "default",
                  inputValue: formValuesState["previewDate"] ?? "",
                  inputType: TextInputType.datetime,
                  label: "Fecha de reserva(*)",
                  validator: (date) => valueIsNotEmpty(date.toString(),
                      errorMessage: "Ingrese la fecha"),
                  hint: formValuesState["court"] != "default"
                      ? "Pulse para seleccionar"
                      : "La cancha es requerida",
                  onChanged: (date) => date,
                ),
                BlocBuilder<ReservationsBloc, ReservationsState>(
                  builder: (context, reservationsState) {
                    if (reservationsState is ReservationLimitExceeded) {
                      return Text(
                        reservationsState.message,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      );
                    }

                    return Container();
                  },
                ),
                Visibility(
                  visible: formValuesState["previewDate"] != null,
                  child: const WeatherWidget(
                      alignment: CrossAxisAlignment.center, labelSize: 22),
                ),
                const Divider(),
              ],
            );
          },
        )
      ],
    );
  }
}
