import 'enum/interview_status.dart';

class Interview {
  String? id;
  String? visitorId;
  String? companyId;
  String? timeOfBooking;
  int? positionInQueue;
  InterviewStatus? status;

  Interview({
    this.id,
    this.visitorId,
    this.companyId,
    this.timeOfBooking,
    this.positionInQueue,
    this.status,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['id'] as String?,
      visitorId: json['visitorId'] as String?,
      companyId: json['companyId'] as String?,
      timeOfBooking: json['timeOfBooking'] as String?,
      positionInQueue: json['positionInQueue'] as int?,
      status: json['status'] != null
          ? InterviewStatusExtension.fromString(json['status'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visitorId': visitorId,
      'companyId': companyId,
      'timeOfBooking': timeOfBooking,
      'positionInQueue': positionInQueue,
      'status': status?.value,
    };
  }
}
