import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHelper {
  // CONFIG HOST URL
  static final _hostUrl = dotenv.env['HOST_URL'] ?? "";

  static final apiURL = "$_hostUrl/api/v1";

  static final login = "$apiURL/login";
  static final report = "$apiURL/report";
  static final letter = "$apiURL/letter";
  static final approvalLetter = "$apiURL/letter/approval";
}
