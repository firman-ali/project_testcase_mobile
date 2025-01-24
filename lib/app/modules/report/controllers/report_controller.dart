import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testcase_project/app/repository/app_repository.dart';
import 'package:testcase_project/app/repository/app_repository_impl.dart';

import '../../../utils/error_response_helper.dart';
import '../../widgets/picked_image_dialog.dart';
import '../../widgets/rounded_dialog.dart';
import '../../widgets/rounded_source_image_sheet.dart';

class ReportController extends GetxController {
  ImagePicker? picker;
  List<XFile> images = [];
  bool canSubmit = false;

  TextEditingController? reportTitleController;
  TextEditingController? reportDescController;
  TextEditingController? reportCitizenName;
  TextEditingController? reportCitizenAddress;
  TextEditingController? reportCitizenEmail;
  TextEditingController? reportCitizenNik;
  TextEditingController? reportCitizenPhone;

  @override
  void onInit() {
    super.onInit();
    picker = ImagePicker();
    reportCitizenName = TextEditingController();
    reportCitizenAddress = TextEditingController();
    reportCitizenEmail = TextEditingController();
    reportCitizenNik = TextEditingController();
    reportCitizenPhone = TextEditingController();
    reportTitleController = TextEditingController();
    reportDescController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    reportCitizenName?.dispose();
    reportCitizenAddress?.dispose();
    reportCitizenEmail?.dispose();
    reportCitizenNik?.dispose();
    reportCitizenPhone?.dispose();
    reportTitleController?.dispose();
    reportDescController?.dispose();
    EasyLoading.dismiss();
  }

  void confirmAddReport() async {
    Get.dialog(
      RoundedDialog(
        title: "Kirim Laporan",
        content: "Apakah Anda yakin akan mengirim laporan?",
        negativeLabelButton: "Cek Kembali",
        positiveLabelButton: "Kirim Data",
        negativeOnPressed: Get.back,
        positiveOnPressed: () {
          if (Get.isDialogOpen == true) Get.back();
          sendReport();
        },
      ),
    );
  }

  void pickImageFromCamera() async {
    if (Get.isBottomSheetOpen == true) Get.back();
    final XFile? photo = await picker?.pickImage(
      source: ImageSource.camera,
      maxHeight: 1280,
      maxWidth: 720,
      imageQuality: 80,
    );
    if (photo != null) {
      images.add(photo);
      changedFormValue();
    }
  }

  void pickImageFromGallery() async {
    if (Get.isBottomSheetOpen == true) Get.back();
    final XFile? image = await picker?.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1280,
      maxWidth: 720,
      imageQuality: 80,
    );
    if (image != null) {
      images.add(image);
      changedFormValue();
    }
  }

  void openSelectOptionImage() {
    Get.bottomSheet(
      RoundedSourceImageSheet(
        galleryOnPressed: () => pickImageFromGallery(),
        cameraOnPressed: () => pickImageFromCamera(),
      ),
    );
  }

  void deletePickedImage(int index) {
    images.removeAt(index);
    changedFormValue();
  }

  void openImage(XFile img) {
    Get.dialog(
      PickedImageDialog(imgPath: img.path),
      barrierDismissible: false,
    );
  }

  void changedFormValue() {
    if (reportCitizenNik?.text.isNotEmpty == true &&
        reportCitizenName?.text.isNotEmpty == true &&
        reportCitizenEmail?.text.isNotEmpty == true &&
        reportTitleController?.text.isNotEmpty == true &&
        reportDescController?.text.isNotEmpty == true &&
        images.isNotEmpty == true) {
      canSubmit = true;
    } else {
      canSubmit = false;
    }
    update();
  }

  Future<void> sendReport() async {
    try {
      AppRepository repo = AppRepositoryImpl();
      await EasyLoading.show();
      final response = await repo.sendLetter(
        citizenName: reportCitizenName?.text ?? "",
        citizenAddress: reportCitizenAddress?.text ?? "",
        citizenEmail: reportCitizenEmail?.text ?? "",
        citizenNik: reportCitizenNik?.text ?? "",
        citizenPhone: reportCitizenPhone?.text ?? "",
        title: reportTitleController?.text ?? "",
        desc: reportDescController?.text ?? "",
        images: images,
      );
      await EasyLoading.dismiss();
      Get.back(result: response);
    } on ReturnErrorException catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        "Error Mengirim Laporan dan Masukan",
        "${e.msg}, Please try again",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        "Error Mengirim Laporan dan Masukan",
        "Please try again or contact system administrator",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
    }
  }
}
