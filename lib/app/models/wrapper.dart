import 'dart:convert';

String wrapperToJson(Wrapper data) => json.encode(data.toJson());

class Wrapper<T> {
  final String status;
  final String? message;
  final String? errors;
  final T data;

  Wrapper({
    required this.status,
    required this.data,
    this.message,
    this.errors,
  });

  factory Wrapper.fromJson(String? status,
          {String? message, String? errors, required T data}) =>
      Wrapper(
        status: status ?? "error",
        message: message,
        data: data,
        errors: errors,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "data": data,
      };
}
