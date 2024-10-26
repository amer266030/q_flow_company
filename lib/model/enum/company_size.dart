enum CompanySize {
  zeroTo50,
  fiftyTo100,
  oneHundredTo200,
  twoHundredTo500,
  fiveHundredPlus
}

extension CompanySizeExtension on CompanySize {
  String get value {
    switch (this) {
      case CompanySize.zeroTo50:
        return '0-50';
      case CompanySize.fiftyTo100:
        return '50-100';
      case CompanySize.oneHundredTo200:
        return '100-200';
      case CompanySize.twoHundredTo500:
        return '200-500';
      case CompanySize.fiveHundredPlus:
        return '500+';
      default:
        return '';
    }
  }

  static CompanySize fromString(String? experience) {
    switch (experience) {
      case '0-50':
        return CompanySize.zeroTo50;
      case '50-100':
        return CompanySize.fiftyTo100;
      case '100-200':
        return CompanySize.oneHundredTo200;
      case '200-500':
        return CompanySize.twoHundredTo500;
      case '500+':
        return CompanySize.fiveHundredPlus;

      default:
        throw ArgumentError('Invalid experience value');
    }
  }
}
