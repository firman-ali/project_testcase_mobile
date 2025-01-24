import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../modules/report/controllers/report_controller.dart';
import '../modules/report_approval/controllers/report_approval_controller.dart';

typedef BindingCreator<S extends Bindings> = S Function();

/// Helper classes for functions in the application
class Utils {
  Utils._();

  /// Variable that stores number of actions when the back press is pressed
  static DateTime? currentBackPressTime;

  static List<BindingCreator<Bindings>> _navBarBindings = [];

  /// Function to override action of onBackPressed
  ///
  /// with [onClosed] callback.
  static Future<bool> backPressToExit({void Function()? onClosed}) async {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar(
        "Are You Sure?",
        "Press Again To Exit",
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.exit_to_app),
        snackPosition: SnackPosition.BOTTOM,
        snackbarStatus: (status) {
          if (status == SnackbarStatus.CLOSED && onClosed != null) {
            onClosed();
          }
        },
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      );
      return Future.value(false);
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return Future.value(true);
  }

  static void backPressed({bool backLastPage = true}) {
    if (Get.isDialogOpen == true) Get.back();
    if (Get.isSnackbarOpen == true) Get.closeAllSnackbars();
    if (backLastPage) Get.back();
  }

  static void initializedNavBar({required List<Bindings> bindings}) {
    if (_navBarBindings.isEmpty == true) {
      _navBarBindings = bindings.map((binding) => () => binding).toList();
    }
  }

  static void loadNavBarBinding(int index) {
    Bindings? bindingCreator = _navBarBindings[index].call();
    bindingCreator.dependencies();
  }

  static void unloadNavBarController(int index) {
    switch (index) {
      case 0:
        Get.delete<ReportApprovalController>();
        break;
      case 2:
        Get.delete<ReportController>();
        break;
      default:
    }
  }

  /// Function for Retrieve formatted datetime with argument [DateTime]
  /// and will return a String value
  /// Format date String: yyyy-MM-dd
  static String requestDateFormat(DateTime? date) {
    return date == null ? "" : DateFormat('yyyy-MM-dd').format(date);
  }

  /// Function for Retrieve formatted datetime with argument [date]
  /// and will return a String value
  /// Format date String: d MMMM y with locale ID
  static String dateFormat(DateTime? date) {
    return date == null
        ? ""
        : DateFormat('d MMMM y', "id_ID").format(date.toLocal());
  }

  /// Function for Retrieve formatted datetime with argument [date]
  /// and will return a String value
  /// Format date String: d MMMM y with locale ID
  static String dateAgeFormat(DateTime? date) {
    return date == null
        ? "0 Tahun"
        : "${DateTime.now().difference(date.toLocal()).inDays ~/ 365} Tahun";
  }

  /// Function for Retrieve formatted today and will return a String value
  ///
  /// Format date String: yyyy-MM-dd with locale ID
  static String dateNowFormat() {
    return DateFormat('yyyy-MM-dd', "id_ID").format(DateTime.now());
  }

  static String getStringDateTimeLog() {
    return DateFormat('d-M-y hh:mm:ss').format(DateTime.now());
  }

  static String getStringTimestamp(int time) {
    return time > 0
        ? DateFormat('dd MMMM yyyy', "id_ID")
            .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
        : "-";
  }

  static int getMonthlyDate({required int year, required int month}) {
    int day = 0;
    switch (month) {
      case 1:
        day = 31;
        break;
      case 2:
        day = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
        break;
      case 3:
        day = 31;
        break;
      case 4:
        day = 30;
        break;
      case 5:
        day = 31;
        break;
      case 6:
        day = 30;
        break;
      case 7:
        day = 31;
        break;
      case 8:
        day = 31;
        break;
      case 9:
        day = 30;
        break;
      case 10:
        day = 31;
        break;
      case 11:
        day = 30;
        break;
      case 12:
        day = 31;
        break;

      default:
        day = 30;
        break;
    }
    return day;
  }
}
