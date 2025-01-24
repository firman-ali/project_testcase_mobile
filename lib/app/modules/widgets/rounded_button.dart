import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.radius = 8,
    this.width,
    this.icon,
    this.disable = false,
  });

  final void Function()? onPressed;
  final String title;
  final Color backgroundColor;
  final double radius;
  final double? width;
  final IconData? icon;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width ?? context.width, 0),
        maximumSize: width != null ? Size(width ?? context.width, 50) : null,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 24,
              color: disable ? Colors.black : Colors.white,
            ),
          if (icon != null) const SizedBox(width: 8.0),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: disable ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
