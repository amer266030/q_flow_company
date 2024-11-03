class BookmarkedVisitor {
  String? id;
  String? visitorId;
  String? companyId;

  BookmarkedVisitor({this.id, this.visitorId, this.companyId});

  factory BookmarkedVisitor.fromJson(Map<String, dynamic> json) {
    return BookmarkedVisitor(
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
