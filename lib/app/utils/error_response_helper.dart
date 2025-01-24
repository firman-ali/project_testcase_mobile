class ErrorResponseException implements Exception {
  String exception;

  ErrorResponseException(this.exception);
}

class ErrorAuthException implements Exception {
  String? exception;

  ErrorAuthException({this.exception});
}

class ErrorRefreshAuthException implements Exception {
  String? exception;

  ErrorRefreshAuthException({this.exception});
}

class ErrorParsingException implements Exception {
  String msg;

  ErrorParsingException(this.msg);
}

class ReturnErrorException implements Exception {
  String msg;

  ReturnErrorException(this.msg);
}
