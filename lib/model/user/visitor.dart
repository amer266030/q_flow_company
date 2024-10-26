import '../enum/experience.dart';
import '../enum/gender.dart';
import '../enum/visitor_status.dart';

class Visitor {
  String? id; // References user_id
  Gender? gender;
  String? fName;
  String? lName;
  Experience? experience;
  String? dob;
  String? resumeUrl;
  String? avatarUrl;
  VisitorStatus? status;

  Visitor({
    this.id,
    this.gender,
    this.fName,
    this.lName,
    this.experience,
    this.dob,
    this.resumeUrl,
    this.avatarUrl,
    required this.status,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'] as String?,
      gender: json['gender'] != null
          ? GenderExtension.fromString(json['gender'] as String?)
          : null,
      fName: json['fName'] as String?,
      lName: json['lName'] as String?,
      experience: json['experience'] != null
          ? ExperienceExtension.fromString(json['experience'] as String?)
          : null,
      status: json['status'] != null
          ? VisitorExtension.fromString(json['status'] as String?)
          : null,
      dob: json['dob'] as String?,
      resumeUrl: json['resumeUrl'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender?.value,
      'fName': fName,
      'lName': lName,
      'experience': experience?.value,
      'status': status?.value,
      'dob': dob,
      'resumeUrl': resumeUrl,
      'avatarUrl': avatarUrl,
    };
  }
}
