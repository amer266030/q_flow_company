class QueueEntry {
  String? id;
  String? interviewId;
  String? companyId;
  int? position;
  String? createdAt;

  QueueEntry({
    this.id,
    this.interviewId,
    this.companyId,
    this.position,
    this.createdAt,
  });

  factory QueueEntry.fromJson(Map<String, dynamic> json) {
    return QueueEntry(
      id: json['id'] as String?,
      interviewId: json['interview_id'] as String?,
      companyId: json['company_id'] as String?,
      position: json['position'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'interview_id': interviewId,
      'company_id': companyId,
      'position': position,
    };
  }
}
