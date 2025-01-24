// To parse this JSON data, do
//
//     final letterResponse = letterResponseFromJson(jsonString);

class ReportResponse {
  final List<ReportRecord> records;

  ReportResponse({
    required this.records,
  });
}

class ReportRecord {
  final int letterId;
  final String citizenName;
  final String citizenNik;
  final String citizenEmail;
  final String citizenPhone;
  final String citizenAddress;
  final String reportTitle;
  final String reportDesc;
  final String reportStatus;
  final int createdAt;

  ReportRecord({
    required this.letterId,
    required this.citizenName,
    required this.citizenNik,
    required this.citizenEmail,
    required this.citizenPhone,
    required this.citizenAddress,
    required this.reportTitle,
    required this.reportDesc,
    required this.reportStatus,
    required this.createdAt,
  });
}
