enum UserRole { visitor, company, organizer }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.visitor:
        return 'Visitor';
      case UserRole.company:
        return 'Company';
      case UserRole.organizer:
        return 'Organizer';
      default:
        return '';
    }
  }

  static UserRole fromString(String? role) {
    switch (role) {
      case 'Visitor':
        return UserRole.visitor;
      case 'Company':
        return UserRole.company;
      case 'Organizer':
        return UserRole.organizer;
      default:
        throw ArgumentError('Invalid gender value');
    }
  }
}
