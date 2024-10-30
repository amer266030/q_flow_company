import 'enums/interview_status.dart';

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
      visitorId: json['visitor_id'] as String?,
      companyId: json['company_id'] as String?,
      timeOfBooking: json['time_of_booking'] as String?,
      positionInQueue: json['position_in_queue'] as int?,
      status: json['status'] != null
          ? InterviewStatusExtension.fromString(json['status'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visitor_id': visitorId,
      'company_id': companyId,
      'time_of_booking': timeOfBooking,
      'position_in_queue': positionInQueue,
      'status': status?.value,
    };
  }
}
