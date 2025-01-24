import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/report_response.dart';
import '../../../repository/app_repository.dart';
import '../../../repository/app_repository_impl.dart';
import '../../../utils/error_response_helper.dart';
import '../../../utils/utils.dart';
import '../../widgets/rounded_dialog.dart';

class HomeController extends GetxController {
  final PagingController<int, ReportRecord> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    getData(page: 1);
  }

  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) {
      getData(page: pageKey);
    });
  }

  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }

  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  Future<void> getData({required int page}) async {
    try {
      AppRepository repo = AppRepositoryImpl();
      final response = await repo.getReports(page: page);
      final isLastPage = response.records.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(response.records);
      } else {
        pagingController.appendPage(response.records, page + 1);
      }
    } on ReturnErrorException catch (e) {
      Get.snackbar(
        "Error Mengambil Data",
        "${e.msg}, Please try again",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
      pagingController.appendLastPage([]);
    } catch (e) {
      Get.snackbar(
        "Error Mengambil Data",
        "Please try again or contact system administrator",
        snackPosition: SnackPosition.BOTTOM,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        maxWidth: Get.width,
      );
      pagingController.appendLastPage([]);
    }
  }

  Future<bool> confirmData() async {
    Get.dialog(
      RoundedDialog(
        color: Colors.blue,
        title: "Selesaikan Pengajuan Laporan",
        content: "Apakah Anda yakin menyelesaiakan laporan ini?",
        negativeLabelButton: "Tidak",
        positiveLabelButton: "Yakin dan Selesai",
        negativeOnPressed: Get.back,
        positiveOnPressed: Utils.backPressed,
      ),
    );
    return Future.value(false);
  }
}
