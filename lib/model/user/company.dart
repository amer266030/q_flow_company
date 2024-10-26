import '../enum/company_size.dart';

class Company {
  String? id; // References user_id
  String? name;
  String? description;
  CompanySize? companySize;
  int? establishedYear;
  int? avgRating;
  String? logoUrl;
  bool? isQueueOpen;

  Company({
    this.id,
    this.name,
    this.description,
    this.companySize,
    this.establishedYear,
    this.avgRating,
    this.logoUrl,
    this.isQueueOpen,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      // Convert the string representation of company size into enum
      companySize: json['company_size'] != null
          ? CompanySizeExtension.fromString(json['company_size'] as String?)
          : null,
      establishedYear: json['established_year'] as int?,
      avgRating: json['avg_rating'] as int?,
      logoUrl: json['logo_url'] as String?,
      isQueueOpen: json['is_queue_open'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'company_size': companySize?.value,
      'established_year': establishedYear,
      'avg_rating': avgRating,
      'logo_url': logoUrl,
      'is_queue_open': isQueueOpen,
    };
  }
}
