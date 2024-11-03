class CompanyRating {
  String? id;
  String? companyId;
  String? visitorId;
  DateTime? ratingDate;

  CompanyRating({this.id, this.companyId, this.visitorId, this.ratingDate});

  factory CompanyRating.fromJson(Map<String, dynamic> json) {
    return CompanyRating(
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
