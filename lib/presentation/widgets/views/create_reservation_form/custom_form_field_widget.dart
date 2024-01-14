import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.inputType,
      required this.validator,
      required this.label,
      this.onChanged,
      this.hint = ""});
  final TextInputType inputType;
  final String label, hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16),
          ),
          TextFormField(
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[600]!)),
                border: const OutlineInputBorder(),
                hintText: hint),
            keyboardType: inputType,
          ),
        ],
      ),
    );
  }
}
