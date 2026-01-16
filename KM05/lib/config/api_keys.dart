import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openRouteServiceKey {
    return dotenv.env['OPENROUTE_API_KEY'] ?? '';
  }
  
  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? '';
  }
  
  static bool get isConfigured {
    return openRouteServiceKey.isNotEmpty && apiBaseUrl.isNotEmpty;
  }
}