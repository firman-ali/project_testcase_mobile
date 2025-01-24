import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({super.key, required this.label, this.isRequired = false});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: label),
        if (isRequired)
          TextSpan(
            text: "*",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
      ]),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
