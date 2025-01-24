import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedDialog extends StatelessWidget {
  const RoundedDialog({
    super.key,
    this.title,
    this.content,
    required this.positiveLabelButton,
    required this.negativeLabelButton,
    this.positiveOnPressed,
    this.negativeOnPressed,
    this.color = Colors.blue,
    this.contentWidget,
  });

  final Widget? contentWidget;
  final Color color;
  final String? title;
  final String? content;
  final String positiveLabelButton;
  final String negativeLabelButton;
  final void Function()? positiveOnPressed;
  final void Function()? negativeOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      iconPadding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 24.0,
      ),
      title: title != null
          ? Text(
              title!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey,
              ),
            )
          : null,
      titlePadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      content: contentWidget ??
          (content != null
              ? Text(
                  content!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                )
              : null),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      actions: [
        TextButton(
          onPressed: negativeOnPressed,
          child: Text(
            negativeLabelButton,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey,
            ),
          ),
        ),
        TextButton(
          onPressed: positiveOnPressed,
          child: Text(
            positiveLabelButton,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.all(24.0),
    );
  }
}
