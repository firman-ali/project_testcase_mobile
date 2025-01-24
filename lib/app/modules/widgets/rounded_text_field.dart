import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
    this.validator,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.maxLines = 1,
    this.initialValue,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final bool? obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool? hideText;

  void changeVisibility() {
    setState(() {
      if (hideText != null) {
        hideText = !hideText!;
      } else {
        hideText = false;
      }
    });
  }

  @override
  void initState() {
    hideText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      obscureText: hideText ?? false,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        counterText: "",
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  widget.readOnly ? Colors.lightBlueAccent : Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  widget.readOnly ? Colors.lightBlueAccent : Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  widget.readOnly ? Colors.lightBlueAccent : Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  widget.readOnly ? Colors.lightBlueAccent : Colors.blueGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: hideText == null
            ? null
            : InkWell(
                onTap: () => changeVisibility(),
                child: hideText == false
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
      ),
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
    );
  }
}
