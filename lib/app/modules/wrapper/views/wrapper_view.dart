import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testcase_project/app/modules/report_approval/views/report_approval_view.dart';

import '../../../utils/utils.dart';
import '../../home/views/home_view.dart';
import '../../report/views/report_view.dart';
import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabView = [
      const HomeView(),
      const ReportView(),
      const ReportApprovalView(),
    ];
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (controller.currentPage == 0) {
                Utils.backPressToExit();
              } else {
                controller.changePage(0);
              }
            },
            child: tabView[controller.currentPage],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) => controller.changePage(value),
              currentIndex: controller.currentPage,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report),
                  label: "Report",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: "Report Approval",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
