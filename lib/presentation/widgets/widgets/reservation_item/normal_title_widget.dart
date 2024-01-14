import 'package:flutter/material.dart';

class NormalTitle extends StatelessWidget {
  const NormalTitle({
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
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.green[400]),
      ),
    );
  }
}
