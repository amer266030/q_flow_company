enum VisitorStatus { inQueue, applied, saved }

extension VisitorExtension on VisitorStatus {
  String get value {
    switch (this) {
      case VisitorStatus.inQueue:
        return 'In Queue';
      case VisitorStatus.applied:
        return 'Applied';
      case VisitorStatus.saved:
        return 'Saved';
      default:
        return '';
    }
  }

  static VisitorStatus fromString(String? status) {
    switch (status) {
      case 'In Queue':
        return VisitorStatus.inQueue;
      case 'Applied':
        return VisitorStatus.applied;
      case 'Saved':
        return VisitorStatus.saved;
      default:
        throw ArgumentError('Invalid status value');
    }
  }
}
