extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeExtension on DateTime {
  String toddmmyyyy() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString().padLeft(4, '0')}';
    // return '${year.toString().padLeft(4, '0')}.${month.toString().padLeft(2, '0')}.${day.toString().padLeft(2, '0')}';
  }
}
