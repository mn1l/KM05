import 'package:intl/intl.dart';

class AppFormatters {
  static String date(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy', 'nl_NL').format(date);
    } catch (e) {
      return dateString;
    }
  }
}