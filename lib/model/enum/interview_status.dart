enum InterviewStatus { upcoming, completed, cancelled }

extension InterviewStatusExtension on InterviewStatus {
  String get value {
    switch (this) {
      case InterviewStatus.upcoming:
        return 'Upcoming';
      case InterviewStatus.completed:
        return 'Completed';
      case InterviewStatus.cancelled:
        return 'Cancelled';
      default:
        return '';
    }
  }

  static InterviewStatus fromString(String? gender) {
    switch (gender) {
      case 'Upcoming':
        return InterviewStatus.upcoming;
      case 'Completed':
        return InterviewStatus.completed;
      case 'Cancelled':
        return InterviewStatus.cancelled;
      default:
        throw ArgumentError('Invalid status value');
    }
  }
}
