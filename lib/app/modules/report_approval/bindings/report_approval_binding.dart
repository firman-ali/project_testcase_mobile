import 'package:get/get.dart';

import '../controllers/report_approval_controller.dart';

class ReportApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportApprovalController>(
      () => ReportApprovalController(),
    );
  }
}
