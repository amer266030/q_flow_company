import '../bookmarks/bookmarked_company.dart';
import '../enums/bootcamp.dart';
import '../enums/experience.dart';
import '../enums/gender.dart';
import '../interview.dart';
import '../skills/skill.dart';
import '../social_links/social_link.dart';

class Visitor {
  String? id;
  Gender? gender;
  String? fName;
  String? lName;
  Experience? experience;
  String? dob;
  Bootcamp? bootcamp;
  String? resumeUrl;
  String? avatarUrl;
  String? externalId;
  List<SocialLink>? socialLinks;
  List<Skill>? skills;
  List<BookmarkedCompany>? bookmarkedCompanies;
  List<Interview>? interviews;

  Visitor({
    this.id,
    this.gender,
    this.fName,
    this.lName,
    this.experience,
    this.dob,
    this.bootcamp,
    this.resumeUrl,
    this.avatarUrl,
    this.externalId,
    this.socialLinks,
    this.skills,
    this.bookmarkedCompanies,
    this.interviews,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'] as String?,
      gender: json['gender'] != null
          ? GenderExtension.fromString(json['gender'] as String?)
          : null,
      fName: json['f_name'] as String?,
      lName: json['l_name'] as String?,
      experience: json['experience'] != null
          ? ExperienceExtension.fromString(json['experience'] as String?)
          : null,
      dob: json['dob'] as String?,
      bootcamp: json['bootcamp'] != null
          ? BootcampExtension.fromString(json['bootcamp'] as String?)
          : null,
      resumeUrl: json['resume_url'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      externalId: json['external_id'] as String?,
      socialLinks: json['social_links'] != null
          ? (json['social_links'] as List)
              .map((link) => SocialLink.fromJson(link))
              .toList()
          : null,
      skills: json['skills'] != null
          ? (json['skills'] as List)
              .map((skill) => Skill.fromJson(skill))
              .toList()
          : null,
      bookmarkedCompanies: json['bookmarked_companies'] != null
          ? (json['bookmarked_companies'] as List)
              .map((bm) => BookmarkedCompany.fromJson(bm))
              .toList()
          : null,
      interviews: json['interviews'] != null
          ? (json['interviews'] as List)
              .map((i) => Interview.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender?.value,
      'f_name': fName,
      'l_name': lName,
      'experience': experience?.value,
      'dob': dob,
      'bootcamp': bootcamp?.value,
      'resume_url': resumeUrl,
      'avatar_url': avatarUrl,
      'external_id': externalId,
    };
  }
}
