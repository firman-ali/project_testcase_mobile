import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:testcase_project/app/repository/app_repository.dart';
import 'package:testcase_project/app/repository/app_repository_impl.dart';
import 'package:testcase_project/app/routes/app_pages.dart';
import 'package:testcase_project/app/utils/error_response_helper.dart';

import '../../../data/shared_preference/preference_helper.dart';

class LoginController extends GetxController {
  TextEditingController? nikController;
  TextEditingController? passwordController;

  @override
  void onInit() {
    super.onInit();
    nikController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }

  Future<void> login() async {
    try {
      await EasyLoading.show();
      AppRepository repo = AppRepositoryImpl();
      final user = await repo.login(
        nik: nikController?.text ?? "",
        password: passwordController?.text ?? "",
      );
      await EasyLoading.dismiss();
      await Get.find<PreferencesHelper>().setUserLoggedIn(user);
      Get.offNamed(Routes.WRAPPER);
    } on ReturnErrorException catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        "Error Masuk Akun",
        "${e.msg}, Periksa kembali nik atau password anda",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        "Error Masuk Akun",
        "Please try again or contact system administrator",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
    }
  }
}
