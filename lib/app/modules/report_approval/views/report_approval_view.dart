import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_approval_controller.dart';

class ReportApprovalView extends GetView<ReportApprovalController> {
  const ReportApprovalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportApprovalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReportApprovalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
