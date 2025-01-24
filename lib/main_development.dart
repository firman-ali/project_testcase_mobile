import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/data/network/api_service.dart';
import 'app/data/shared_preference/preference_helper.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/utils.dart';
import 'main.dart';

/// Main function for running production env
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  await dotenv.load(fileName: "development.env");
  Utils.initializedNavBar(bindings: AppPages.NAV_PAGE_BINDINGS);
  await initializeDateFormatting('id_ID', null);
  configLoading();
  runApp(MyApp(route: Routes.WRAPPER));
}

void initServices() {
  Get.put(PreferencesHelper());
  Get.put(ApiService());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.black
    ..indicatorColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..boxShadow = [const BoxShadow(color: Colors.transparent)]
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}
