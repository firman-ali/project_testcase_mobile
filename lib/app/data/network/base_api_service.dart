import 'package:http/http.dart' as http;

import '../../models/wrapper.dart';

abstract class BaseApiService {
  Future<Wrapper<dynamic>> getResponse(
    String url, {
    String? name,
    bool authenticationCheck = false,
  });
  Future<Wrapper<dynamic>> putResponse(
    String url,
    String encodeJson, {
    String? name,
    bool authenticationCheck = false,
  });
  Future<Wrapper<dynamic>> postResponse(
    String url,
    String encodeJson, {
    String? name,
    bool authenticationCheck = false,
  });
  Future<Wrapper<dynamic>> deleteResponse(
    String url, {
    String? encodeJson,
    String? name,
    bool authenticationCheck = false,
  });
  Future<Wrapper<dynamic>> postMultipartResponse(
    String url, {
    List<http.MultipartFile?>? files,
    Map<String, String>? fields,
    String? name,
    bool authenticationCheck = false,
  });
  Future<Wrapper<dynamic>> putMultipartResponse(
    String url, {
    List<http.MultipartFile?>? files,
    Map<String, String>? fields,
    String? name,
    bool authenticationCheck = false,
  });
}
