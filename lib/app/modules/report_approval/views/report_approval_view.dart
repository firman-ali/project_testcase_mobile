import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../models/report_response.dart';
import '../../../utils/utils.dart';
import '../../widgets/empty_data.dart';
import '../controllers/report_approval_controller.dart';

class ReportApprovalView extends GetView<ReportApprovalController> {
  const ReportApprovalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approval Laporan"),
      ),
      body: PagedListView<int, ReportRecord>.separated(
        padding: const EdgeInsets.all(24.0),
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<ReportRecord>(
          itemBuilder: (context, item, index) => ApprovalReportCard(
            report: item,
            onClick: controller.confirmData,
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const ShimmerApprovalReportCard(),
          newPageProgressIndicatorBuilder: (_) =>
              const ShimmerApprovalReportCard(),
          noItemsFoundIndicatorBuilder: (_) => const EmptyData(),
        ),
        separatorBuilder: (_, index) => const SizedBox(height: 16.0),
      ),
    );
  }
}

class ApprovalReportCard extends StatelessWidget {
  const ApprovalReportCard({super.key, required this.report, this.onClick});

  final ReportRecord report;
  final void Function()? onClick;

  Color getStatusColor(String status) {
    switch (status) {
      case "selesai":
        return Colors.blue;
      case "diproses":
        return Colors.purple;
      case "diterima":
        return Colors.green;
      case "ditolak":
        return Colors.red;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: report.reportStatus == "diproses" ? onClick : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: getStatusColor(report.reportStatus.toLowerCase()),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                report.reportStatus.capitalizeFirst ?? "",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              report.reportTitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8.0),
                Text(
                  Utils.getStringTimestamp(report.createdAt),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Icon(
                  Icons.report,
                  size: 18,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8.0),
                Text(
                  report.citizenName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerApprovalReportCard extends StatelessWidget {
  const ShimmerApprovalReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(90),
            ),
            child: Text(
              "Loading",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            "Loading",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                size: 18,
                color: Colors.blue,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Loading",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              const Icon(
                Icons.report,
                size: 18,
                color: Colors.blue,
              ),
              const SizedBox(width: 8.0),
              Text(
                "Loading",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
