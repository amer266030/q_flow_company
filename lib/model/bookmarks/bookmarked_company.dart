class BookmarkedCompany {
  String? id;
  String? visitorId;
  String? companyId;

  BookmarkedCompany({this.id, this.visitorId, this.companyId});

  factory BookmarkedCompany.fromJson(Map<String, dynamic> json) {
    return BookmarkedCompany(
      id: json['id'],
      visitorId: json['visitor_id'],
      companyId: json['company_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitor_id': visitorId,
      'company_id': companyId,
    };
  }
}
