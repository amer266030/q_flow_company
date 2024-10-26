enum VisitorRating {
  technicalSkills,
  softSkills,
  jobSkills,
}

extension RatingExtension on VisitorRating {
  String get value {
    switch (this) {
      case VisitorRating.technicalSkills:
        return 'Technical Skills';
      case VisitorRating.softSkills:
        return 'Soft Skills';
      case VisitorRating.jobSkills:
        return 'job Skills';
    }
  }

  static VisitorRating fromString(String? rate) {
    switch (rate) {
      case 'Technical Skills':
        return VisitorRating.technicalSkills;
      case 'Soft Skills':
        return VisitorRating.softSkills;
      case 'job Skills':
        return VisitorRating.jobSkills;

      default:
        throw ArgumentError('Invalid experience value');
    }
  }
}
