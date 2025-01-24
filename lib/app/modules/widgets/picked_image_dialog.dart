import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickedImageDialog extends StatelessWidget {
  const PickedImageDialog({super.key, required this.imgPath});

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.image, size: 16),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(File(imgPath)),
          )
        ],
      ),
    );
  }
}
