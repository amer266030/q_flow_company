import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('MM/dd/yyyy').format(this);
  }

  String toFormattedStringWithTime() {
    return DateFormat('MM/dd/yyyy HH:mm').format(this);
  }

  String toFormattedStringTimeOnly() {
    return DateFormat('hh:mm a').format(this);
  }
}

extension StringToDateTime on String {
  DateTime toDate() {
    return DateFormat('MM/dd/yyyy').parse(this);
  }

  DateTime toDateTime() {
    return DateFormat('MM/dd/yyyy HH:mm').parse(this); // Parses date and time
  }
}
