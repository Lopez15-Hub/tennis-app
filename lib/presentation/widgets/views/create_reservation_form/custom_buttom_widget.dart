import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.formKey, required this.onPressed});

  final GlobalKey<FormState> formKey;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 60),
              elevation: 1,
              backgroundColor: Colors.green[300]),
          onPressed: onPressed,
          child: const Text(
            "Reservar cancha",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )),
    );
  }
}
