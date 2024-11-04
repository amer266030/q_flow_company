class VisitorRating {
  String? id;
  String? companyId;
  String? visitorId;
  DateTime? ratingDate;

  VisitorRating({this.id, this.companyId, this.visitorId, this.ratingDate});

  factory VisitorRating.fromJson(Map<String, dynamic> json) {
    return VisitorRating(
      id: json['id'] as String?,
      companyId: json['company_id'] as String?,
      visitorId: json['visitor_id'] as String?,
      ratingDate: json['rating_date'] as DateTime?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'visitor_id': visitorId,
    };
  }
}
