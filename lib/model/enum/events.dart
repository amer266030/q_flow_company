enum Events {
  jobFair111,
  jobFair222,
  jobFair333,
}

extension EventsExtension on Events {
  String get value {
    switch (this) {
      case Events.jobFair111:
        return 'job Fair 111';
      case Events.jobFair222:
        return 'job Fair 222';
      case Events.jobFair333:
        return 'job Fair 333';
    }
  }

  static Events fromString(String? event) {
    switch (event) {
      case 'Job Fair 111':
        return Events.jobFair111;
      case 'Job Fair 222':
        return Events.jobFair222;
      case 'Jop Fair 333':
        return Events.jobFair333;

      default:
        throw ArgumentError('Invalid experience value');
    }
  }
}
