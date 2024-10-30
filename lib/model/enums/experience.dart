enum Experience { none, lessThanOne, oneToFive, fiveToNine, moreThanNine }

extension ExperienceExtension on Experience {
  String get value {
    switch (this) {
      case Experience.none:
        return 'None';
      case Experience.lessThanOne:
        return '>1 yr';
      case Experience.oneToFive:
        return '1-5 yrs';
      case Experience.fiveToNine:
        return '5-9 yrs';
      case Experience.moreThanNine:
        return '9+ yrs';
      default:
        return '';
    }
  }

  static Experience fromString(String? experience) {
    switch (experience) {
      case 'None':
        return Experience.none;
      case '>1 yr':
        return Experience.lessThanOne;
      case '1-5 yrs':
        return Experience.oneToFive;
      case '5-9 yrs':
        return Experience.fiveToNine;
      case '9+ yrs':
        return Experience.moreThanNine;

      default:
        throw ArgumentError('Invalid experience value');
    }
  }
}
