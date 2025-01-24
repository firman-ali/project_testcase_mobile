import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedOutlinedButton extends StatelessWidget {
  const RoundedOutlinedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.borderColor = Colors.blue,
    this.textColor = Colors.blue,
    this.radius = 8,
  });

  final void Function()? onPressed;
  final String title;
  final Color borderColor;
  final Color textColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(context.width, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        side: BorderSide(
          color: onPressed != null ? borderColor : Colors.blueGrey,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: onPressed != null ? textColor : Colors.blueGrey,
        ),
      ),
    );
  }
}
