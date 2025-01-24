import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/wrapper.dart';
import '../../routes/app_pages.dart';
import '../../utils/error_response_helper.dart';
import '../shared_preference/preference_helper.dart';
import 'network.dart';

class ApiService extends GetxService implements BaseApiService {
  late http.Client client;
  late PreferencesHelper prefHelper;
  static const String className = "ApiService";

  @override
  void onInit() {
    super.onInit();
    client = http.Client();
    prefHelper = Get.find<PreferencesHelper>();
  }

  Map<String, String> getHeaders({
    String? auth,
    bool jsonData = true,
  }) {
    return auth != null
        ? {
            'Authorization': auth,
            'Content-Type': jsonData
                ? 'application/json;charset=utf-8'
                : 'multipart/form-data',
            'X-FE-Source': 'mobile-apps',
          }
        : {
            'Content-Type': jsonData
                ? 'application/json;charset=utf-8'
                : 'multipart/form-data',
            'X-FE-Source': 'mobile-apps',
          };
  }

  @override
  Future<Wrapper<dynamic>> getResponse(
    String url, {
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final response = await client
          .get(
            Uri.parse(url),
            headers: getHeaders(auth: auth),
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      LogNetworkInterceptor.show(
        response,
        name: name ?? "GET",
      );
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException();
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        errors: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
        errors: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
        message: e.toString(),
      );
    }
  }

  @override
  Future<Wrapper<dynamic>> postResponse(
    String url,
    String encodeJson, {
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final response = await client
          .post(
            Uri.parse(url),
            headers: getHeaders(auth: auth),
            body: encodeJson,
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      LogNetworkInterceptor.show(
        response,
        body: encodeJson,
        name: name ?? "POST",
      );
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException();
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
      );
    }
  }

  @override
  Future<Wrapper<dynamic>> deleteResponse(
    String url, {
    String? encodeJson,
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final response = await client
          .delete(
            Uri.parse(url),
            headers: getHeaders(auth: auth),
            body: encodeJson,
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      LogNetworkInterceptor.show(
        response,
        body: encodeJson,
        name: name ?? "DELETE",
      );
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException();
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
      );
    }
  }

  @override
  Future<Wrapper<dynamic>> postMultipartResponse(
    String url, {
    List<http.MultipartFile?>? files,
    Map<String, String>? fields,
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers.addAll(getHeaders(auth: auth, jsonData: false));
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        for (var file in files) {
          if (file != null) request.files.add(file);
        }
      }
      final response = await request.send().timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      String streamResponse = "";
      await LogNetworkInterceptor.showMultipartRequest(
        response,
        body: request,
        name: name ?? "MULTIPART POST",
        onStreamResponse: (res) => streamResponse = res,
      );
      try {
        final jsonResponse = json.decode(streamResponse);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException();
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
      );
    }
  }

  @override
  Future<Wrapper<dynamic>> putResponse(
    String url,
    String encodeJson, {
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final response = await client
          .put(Uri.parse(url),
              headers: getHeaders(auth: auth), body: encodeJson)
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      LogNetworkInterceptor.show(
        response,
        body: encodeJson,
        name: name ?? "POST",
      );
      try {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException(exception: jsonResponse["message"]);
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
      );
    }
  }

  @override
  Future<Wrapper<dynamic>> putMultipartResponse(
    String url, {
    List<http.MultipartFile?>? files,
    Map<String, String>? fields,
    String? name,
    bool authenticationCheck = false,
  }) async {
    try {
      final auth = await prefHelper.authToken;
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse(url),
      );
      request.headers.addAll(getHeaders(auth: auth, jsonData: false));
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        for (var file in files) {
          if (file != null) request.files.add(file);
        }
      }
      final response = await request.send().timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw const SocketException("connection timeout"),
          );
      String streamResponse = "";
      await LogNetworkInterceptor.showMultipartRequest(
        response,
        body: request,
        name: name ?? "MULTIPART PUT",
        onStreamResponse: (res) => streamResponse = res,
      );
      try {
        final jsonResponse = json.decode(streamResponse);
        if (jsonResponse["message"] == "Invalid or expired JWT" &&
            authenticationCheck) {
          throw ErrorAuthException();
        }
        return Wrapper(
          status: jsonResponse["status"],
          data: jsonResponse["data"],
          message: jsonResponse["message"],
          errors: jsonResponse["errors"],
        );
      } on ErrorAuthException {
        rethrow;
      } catch (e) {
        throw ErrorParsingException(e.toString());
      }
    } on SocketException {
      return Wrapper.fromJson(
        "error",
        message: "connection lost or timeout",
        data: null,
      );
    } on ErrorAuthException catch (err) {
      await prefHelper.setUserLoggedOut();
      Get.offAllNamed(Routes.LOGIN);
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.exception ?? "session timeout",
      );
    } on ErrorParsingException catch (err) {
      return Wrapper.fromJson(
        "error",
        data: null,
        message: err.msg,
      );
    } catch (e) {
      e.printError();
      return Wrapper.fromJson(
        "error",
        data: null,
      );
    }
  }
}
