import '../enum/tech_skill.dart';

class Skill {
  String? id;
  TechSkill? techSkill;

  Skill({this.id, this.techSkill});

  Map<String, dynamic> toJson() {
    return {'id': id, 'techSkill': techSkill?.value};
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      techSkill: json['techSkill'] != null
          ? TechSkillExtension.fromString(json['techSkill'])
          : null,
    );
  }
}
