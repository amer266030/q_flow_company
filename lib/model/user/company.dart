import '../enums/company_size.dart';
import '../skills/skill.dart';
import '../social_links/social_link.dart';

class Company {
  String? id; // References profile_id
  String? name;
  String? description;
  CompanySize? companySize;
  String? establishedYear;
  int? avgRating;
  String? logoUrl;
  bool? isQueueOpen;
  List<SocialLink>? socialLinks;
  List<Skill>? skills;

  Company({
    this.id,
    this.name,
    this.description,
    this.companySize,
    this.establishedYear,
    this.avgRating,
    this.logoUrl,
    this.isQueueOpen = false,
    this.socialLinks,
    this.skills,
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
      establishedYear: json['established_year'] as String?,
      avgRating: json['avg_rating'] as int?,
      logoUrl: json['logo_url'] as String?,
      isQueueOpen: json['is_queue_open'] as bool?,
      socialLinks: json['social_links'] != null
          ? (json['social_links'] as List)
              .map((link) => SocialLink.fromJson(link))
              .toList()
          : null,
      skills: json['skills'] != null
          ? (json['skills'] as List)
              .map((link) => Skill.fromJson(link))
              .toList()
          : null,
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
      // 'social_links': socialLinks?.map((link) => link.toJson()).toList(),
      // 'skills': skills?.map((skill) => skill.toJson()).toList(),
    };
  }
}
