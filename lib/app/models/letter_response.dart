// To parse this JSON data, do
//
//     final letterResponse = letterResponseFromJson(jsonString);

import 'dart:convert';

class LetterResponse {
  final List<LetterRecord> records;

  LetterResponse({
    required this.records,
  });
}

class LetterRecord {
  final int letterId;
  final String citizenName;
  final String citizenNIK;
  final int createdAt;

  LetterRecord({
    required this.letterId,
    required this.citizenName,
    required this.citizenNIK,

    required this.createdAt,
  });

}
