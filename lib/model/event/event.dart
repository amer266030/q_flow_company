class Event {
  String? id;
  String? organizerId;
  String? name;
  String? location;
  String? imgUrl;
  bool didInviteCompanies;
  bool didInviteUsers;
  String? startDate;
  String? endDate;

  Event({
    this.id,
    this.organizerId,
    this.name,
    this.location,
    this.imgUrl,
    this.didInviteCompanies = false,
    this.didInviteUsers = false,
    this.startDate,
    this.endDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String?,
      organizerId: json['organizer_id'] as String?,
      name: json['name'] as String?,
      location: json['location'] as String?,
      imgUrl: json['img_url'] as String?,
      didInviteCompanies: json['did_invite_companies'] as bool,
      didInviteUsers: json['did_invite_users'] as bool,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizer_id': organizerId,
      'name': name,
      'location': location,
      'img_url': imgUrl,
      'did_invite_companies': didInviteCompanies,
      'did_invite_users': didInviteUsers,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
