import 'package:testcase_project/app/models/report_response.dart';

import '../models/login_response.dart';

class DummyData {
  static ReportResponse reportResponse = ReportResponse(records: [
    ReportRecord(
      letterId: 1,
      citizenName: "Nama Tester",
      citizenNik: "123",
      citizenEmail: "test@test.com",
      citizenPhone: "123456",
      citizenAddress: "Alamat Test",
      reportTitle: "Judul Test 1",
      reportDesc: "Deskripsi Test 1",
      reportStatus: "diproses",
      createdAt: 1737713223,
    ),
    ReportRecord(
      letterId: 2,
      citizenName: "Nama Test",
      citizenNik: "1234",
      citizenEmail: "testing@test.com",
      citizenPhone: "7890123",
      citizenAddress: "Alamat Testing",
      reportTitle: "Judul Test 2",
      reportDesc: "Deskripsi Test 2",
      reportStatus: "selesai",
      createdAt: 1737713223,
    ),
    ReportRecord(
      letterId: 3,
      citizenName: "Nama Testing",
      citizenNik: "1234",
      citizenEmail: "testing@testing.com",
      citizenPhone: "098765",
      citizenAddress: "Alamat Testing Testing",
      reportTitle: "Judul Test 3",
      reportDesc: "Deskripsi Test 3",
      reportStatus: "ditolak",
      createdAt: 1737713223,
    ),
    ReportRecord(
      letterId: 4,
      citizenName: "Nama Tester",
      citizenNik: "123",
      citizenEmail: "test@test.com",
      citizenPhone: "123456",
      citizenAddress: "Alamat Test",
      reportTitle: "Judul Test 4",
      reportDesc: "Deskripsi Test 4",
      reportStatus: "diterima",
      createdAt: 1737713223,
    ),
  ]);

  static LoginResponse loginResponse = LoginResponse(
    token: "123",
    citizenName: "Admin",
    roleId: 99,
    citizenId: 999,
    profilePictureUrl: '',
  );
}
