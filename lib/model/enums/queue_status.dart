enum QueueStatus { open, close }

extension QueueStatusExtension on QueueStatus {
  String get value {
    switch (this) {
      case QueueStatus.open:
        return 'Open';
      case QueueStatus.close:
        return 'Close';
      default:
        return '';
    }
  }

  static QueueStatus fromString(String? status) {
    switch (status) {
      case 'Open':
        return QueueStatus.open;
      case 'Close':
        return QueueStatus.close;
      default:
        throw ArgumentError('Invalid status value');
    }
  }
}
