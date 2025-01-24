import 'package:get/get.dart';

import '../../../data/shared_preference/preference_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class WrapperController extends GetxController {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  @override
  void onInit() {
    super.onInit();
    Utils.loadNavBarBinding(0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int index) async {
    final userLoggedIn = await Get.find<PreferencesHelper>().isLoggedIn;
    if (userLoggedIn == false && index == 2) {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }
    Utils.unloadNavBarController(_currentPage);
    Utils.loadNavBarBinding(index);
    _currentPage = index;
    update();
  }
}
