import '../enums/user_social_link.dart';

class SocialLink {
  String? id;
  String? visitorId;
  String? companyId;
  LinkType? linkType;
  String? url;

  SocialLink(
      {this.id, this.visitorId, this.companyId, this.linkType, this.url});

  // Convert JSON to SocialLink object
  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      id: json['id'] as String?,
      visitorId: json['visitor_id'] as String?,
      companyId: json['company_id'] as String?,
      linkType: json['link_type'] != null
          ? LinkTypeExtension.fromString(json['link_type'] as String)
          : null,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitor_id': visitorId,
      'company_id': companyId,
      'link_type': linkType?.value,
      'url': url,
    };
  }
}
