enum Reports { majors, company, rating, times }

extension ReportsExtension on Reports {
  String get value {
    switch (this) {
      case Reports.majors:
        return 'Majors';
      case Reports.company:
        return 'Company';
      case Reports.rating:
        return 'Rating';
      case Reports.times:
        return 'Times';
      default:
        return '';
    }
  }

  static Reports fromString(String? report) {
    switch (report) {
      case 'Majors':
        return Reports.majors;
      case 'Company':
        return Reports.company;
      case 'Rating':
        return Reports.rating;
      case 'Times':
        return Reports.times;
      default:
        throw ArgumentError('Invalid status value');
    }
  }
}
