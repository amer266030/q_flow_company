enum Gender { male, female }

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      default:
        return '';
    }
  }

  static Gender fromString(String? gender) {
    switch (gender) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      default:
        throw ArgumentError('Invalid gender value');
    }
  }
}
