import 'dart:io';

import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../data/network/network.dart';
import '../models/approve_letter_request.dart';
import '../models/letter_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../utils/error_response_helper.dart';
import '../utils/utils.dart';
import 'app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final BaseApiService _apiService = Get.find<ApiService>();

  @override
  Future<LoginResponse> login({
    required String nik,
    required String password,
  }) async {
    return LoginResponse(
      token: "123",
      citizenName: "Admin",
      roleId: 99, citizenId: 999, profilePictureUrl: '',
    );
    final reqBody = LoginRequest(nik: nik, password: password);
    final response = await _apiService.postResponse(
      ApiHelper.login,
      loginRequestToJson(reqBody),
      name: 'Login',
    );
    if (response.status == "success") {
      try {
        return LoginResponse.fromJson(response.data);
      } catch (e) {
        throw ReturnErrorException("response data not valid");
      }
    } else {
      throw ReturnErrorException(response.message ?? "");
    }
  }

  @override
  Future<LetterResponse> getLetters({
    int limit = 10,
    int page = 1,
    String? letterStatus,
    bool? direction,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return LetterResponse( records: [

    ]);
    String url;
    if (direction == true) {
      url = "${ApiHelper.letter}?limit=$limit&page=$page&direction=in";
    } else if (direction == false) {
      url = "${ApiHelper.letter}?limit=$limit&page=$page&direction=out";
    } else {
      url = "${ApiHelper.letter}?limit=$limit&page=$page";
    }
    if (letterStatus != null) url += "&letter_status=$letterStatus";
    if (startDate != null || endDate != null) {
      url += "&start_date=${Utils.requestDateFormat(startDate)}"
          "&end_date=${Utils.requestDateFormat(endDate)}";
    }
    final response = await _apiService.getResponse(
      url,
      name: "Letter",
      authenticationCheck: true,
    );
  }

  @override
  Future<bool> sendLetter({
    required String citizenName,
    required String citizenNik,
    required String citizenAddress,
    required String citizenPhone,
    required String citizenEmail,
    required String title,
    required String desc,
    required List<XFile> images,
  }) async {
    return true;
    var requestFiles = <http.MultipartFile>[];
    var requestForm = <String, String>{};
    requestForm["citizen_name"] = citizenName;
    requestForm["citizen_nik"] = citizenNik;
    requestForm["citizen_address"] = citizenAddress;
    requestForm["citizen_phone"] = citizenPhone;
    if (images.isNotEmpty == true) {
      for (var image in images) {
        requestFiles.add(
          http.MultipartFile(
            'images',
            File(image.path).readAsBytes().asStream(),
            File(image.path).lengthSync(),
            filename: image.path.split("/").last,
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }
    }
    final response = await _apiService.postMultipartResponse(
      ApiHelper.report,
      files: requestFiles,
      fields: requestForm,
      name: "Add Report",
      authenticationCheck: true,
    );
    if (response.status == "success") {
      try {
        return true;
      } catch (e) {
        throw ReturnErrorException("response data not valid");
      }
    } else {
      throw ReturnErrorException(response.message ?? "");
    }
  }

  @override
  Future<bool> approvalLetter({
    required int letterId,
    required bool status,
    String? date,
    String? number,
    String? declineReason,
  }) async {
    return true;
    final body = ApproveLetterRequest(
      letterId: letterId,
      number: number,
      date: date,
      status: status,
      declineReason: declineReason,
    );
    final response = await _apiService.postResponse(
      ApiHelper.approvalLetter,
      approveLetterRequestToJson(body),
      name: "Approval Letter",
      authenticationCheck: true,
    );
    if (response.status == "success") {
      try {
        return true;
      } catch (e) {
        throw ReturnErrorException("response data not valid");
      }
    } else {
      throw ReturnErrorException(response.message ?? "");
    }
  }
}
