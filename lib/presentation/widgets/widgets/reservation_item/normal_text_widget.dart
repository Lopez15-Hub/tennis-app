import 'package:flutter/material.dart';


class NormalText extends StatelessWidget {
  const NormalText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
