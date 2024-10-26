enum QueueLength { all, lessThanFive, sixToTen, elevenTo19, twentyPlus }

extension ExperienceExtension on QueueLength {
  String get value {
    switch (this) {
      case QueueLength.all:
        return 'all';
      case QueueLength.lessThanFive:
        return '>5';
      case QueueLength.sixToTen:
        return '6-10';
      case QueueLength.elevenTo19:
        return '11-19';
      case QueueLength.twentyPlus:
        return '20+';
      default:
        return '';
    }
  }

  static QueueLength fromString(String? experience) {
    switch (experience) {
      case 'all':
        return QueueLength.all;
      case '>5':
        return QueueLength.lessThanFive;
      case '6-10':
        return QueueLength.sixToTen;
      case '11-19':
        return QueueLength.elevenTo19;
      case '20+':
        return QueueLength.twentyPlus;

      default:
        throw ArgumentError('Invalid experience value');
    }
  }
}
