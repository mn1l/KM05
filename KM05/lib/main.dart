import 'package:carsmeelien/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('nl_NL', null);
  
  try {
    await dotenv.load(fileName: ".env");
    debugPrint('Environment variables loaded successfully');
  } catch (e) {
    debugPrint('Could not load .env file: $e');
  }
  
  runApp(const MyApp());
}