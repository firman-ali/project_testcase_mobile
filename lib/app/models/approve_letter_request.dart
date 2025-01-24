import 'dart:convert';

String approveLetterRequestToJson(ApproveLetterRequest data) =>
    json.encode(data.toJson());

class ApproveLetterRequest {
  final int letterId;
  final String? number;
  final String? date;
  final bool status;
  final String? declineReason;

  ApproveLetterRequest({
    required this.letterId,
    required this.status,
    this.number,
    this.date,
    this.declineReason,
  });

  Map<String, dynamic> toJson() => {
        "id": letterId,
        "kelian_approval": status,
        if (number != null) "kelian_registration_number": number,
        if (date != null) "confirmed_date_by_kelian": date,
        if (declineReason != null) "decline_reason": declineReason,
      };
}
