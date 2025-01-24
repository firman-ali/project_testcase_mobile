import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/report_approval/bindings/report_approval_binding.dart';
import '../modules/report_approval/views/report_approval_view.dart';
import '../modules/wrapper/bindings/wrapper_binding.dart';
import '../modules/wrapper/views/wrapper_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final NAV_PAGE_BINDINGS = [
    HomeBinding(),
    ReportBinding(),
    ReportApprovalBinding(),
  ];

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WRAPPER,
      page: () => const WrapperView(),
      binding: WrapperBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_APPROVAL,
      page: () => const ReportApprovalView(),
      binding: ReportApprovalBinding(),
    ),
  ];
}
