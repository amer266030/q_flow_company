// Created after Auth

class EventInvitedVisitor {
  String? eventId;
  String? visitorId;

  EventInvitedVisitor({this.eventId, this.visitorId});

  factory EventInvitedVisitor.fromJson(Map<String, dynamic> json) {
    return EventInvitedVisitor(
      eventId: json['event_id'] as String?,
      visitorId: json['visitor_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'visitor_id': visitorId,
    };
  }
}
