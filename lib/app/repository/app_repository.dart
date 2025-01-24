import 'package:image_picker/image_picker.dart';

import '../models/letter_response.dart';
import '../models/login_response.dart';

abstract class AppRepository {
  Future<LoginResponse> login({
    required String nik,
    required String password,
  });

  Future<LetterResponse> getLetters({
    int limit = 10,
    int page = 1,
    String? letterStatus,
    bool? direction,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<bool> sendLetter({
    required String citizenName,
    required String citizenNik,
    required String citizenAddress,
    required String citizenPhone,
    required String citizenEmail,
    required String title,
    required String desc,
    required List<XFile> images,
  });

  Future<bool> approvalLetter({
    required int letterId,
    required bool status,
    String? date,
    String? number,
    String? declineReason,
  });
}
