import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedSourceImageSheet extends StatelessWidget {
  const RoundedSourceImageSheet({
    super.key,
    this.galleryOnPressed,
    this.cameraOnPressed,
  });

  final void Function()? galleryOnPressed;
  final void Function()? cameraOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: context.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 75,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[30],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            "Pilih Opsi Upload Gambar",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: cameraOnPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: context.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    "Ambil Foto dengan Kamera",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: galleryOnPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: context.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.folder,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    "Pilih Lewat Galeri",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
