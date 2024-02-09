import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  const CustomChip({
    super.key,
    required this.context,
    required this.label,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 1,
              spreadRadius: -0.5,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: -1.5,
              offset: Offset(0, 3),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 6,
              spreadRadius: -3,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 12,
              spreadRadius: -6,
              offset: Offset(0, 12),
            ),
            BoxShadow(
              color: Color.fromARGB(6, 0, 0, 0),
              blurRadius: 24,
              spreadRadius: -12,
              offset: Offset(0, 24),
            ),
          ]),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
