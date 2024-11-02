import '../enums/tech_skill.dart';

class Skill {
  String? id;
  String? visitorId;
  String? companyId;
  TechSkill? techSkill;

  Skill({this.id, this.visitorId, this.companyId, this.techSkill});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      visitorId: json['visitor_id'],
      companyId: json['company_id'],
      techSkill: json['tech_skill'] != null
          ? TechSkillExtension.fromString(json['tech_skill'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitor_id': visitorId,
      'company_id': companyId,
      'tech_skill': techSkill?.value
    };
  }
}
