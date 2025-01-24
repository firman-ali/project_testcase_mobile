import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class LogNetworkInterceptor {
  static String className(String time) => "$time LogNetwork";

  static void show(
    http.Response response, {
    String? body,
    required String name,
  }) {
    final now = Utils.getStringDateTimeLog();
    if (response.statusCode != 200) {
      log('Failed [${response.request?.method}] $name', name: className(now));
    }
    if (kDebugMode) {
      log("Req [${response.request?.method}] => ${response.request?.url}",
          name: className(now));
      log("Headers => ${response.request?.headers}", name: className(now));
      if (body != null) {
        log("$name req body: $body", name: className(now));
      }
      log("$name res body: ${response.body}", name: className(now));
    }
  }

  static Future<void> showMultipartRequest(
    http.StreamedResponse response, {
    http.MultipartRequest? body,
    required String name,
    void Function(String)? onStreamResponse,
  }) async {
    final now = Utils.getStringDateTimeLog();
    final streamResponse = await response.stream.bytesToString();
    if (onStreamResponse != null) {
      onStreamResponse(streamResponse);
    }
    if (kDebugMode) {
      log("Req [${response.request?.method}] => ${response.request?.url}",
          name: className(now));
      log("Headers => ${response.request?.headers}", name: className(now));
      if (body != null) {
        log("$name req body fields: ${body.fields}", name: className(now));
        log("$name req body files: ${body.files}", name: className(now));
        if (body.files.isNotEmpty) {
          var logMsg = "$name req body files size: [";
          var size = "";
          for (var i = 0; i < body.files.length; i++) {
            size += "${body.files[i].length}";
            if (i + 1 < body.files.length) size += ",";
          }
          logMsg += "$size]";
          log(logMsg, name: className(now));
        }
      }
      log("$name res body: $streamResponse", name: className(now));
    }
  }
}
