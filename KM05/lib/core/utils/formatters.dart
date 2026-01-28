import 'package:intl/intl.dart';

class AppFormatters {
  static String shortDate(dynamic input) {
    if (input == null) return 'Kies data';
    
    DateTime? date;
    
    if (input is DateTime) {
      date = input;
    } else if (input is String) {
      date = DateTime.tryParse(input);
    }

    if (date != null) {
      return DateFormat('dd MMM', 'nl_NL').format(date);
    }
    
    return input.toString();
  }

  static String date(dynamic input) {
    if (input == null) return '';
    
    DateTime? date;
    
    if (input is DateTime) {
      date = input;
    } else if (input is String) {
      date = DateTime.tryParse(input);
    }

    if (date != null) {
      return DateFormat('d MMM yyyy', 'nl_NL').format(date);
    }
    
    return input.toString();
  }
}