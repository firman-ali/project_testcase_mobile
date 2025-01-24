import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedSelectField extends StatelessWidget {
  const RoundedSelectField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onTap,
    required this.icon,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      onTap: onTap,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}
