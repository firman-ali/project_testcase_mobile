import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageItem extends StatelessWidget {
  const PickedImageItem({
    super.key,
    required this.imgFile,
    this.onImageTap,
    this.onDeletePressed,
  });

  final XFile imgFile;
  final void Function()? onImageTap;
  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onImageTap,
              child: Container(
                width: 63,
                height: 63,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(File(imgFile.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onDeletePressed,
              borderRadius: BorderRadius.circular(90),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Icon(
                  Icons.image,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
