import 'dart:convert';

import 'package:carsmeelien/config/api_keys.dart';
import 'package:carsmeelien/models/inspection.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${ApiKeys.apiBaseUrl}/api/inspections';

Future<Inspection> postInspection(Inspection inspection) async {
  return await service.post<Inspection>(
    apiUrl,
    Inspection.fromJson,
    jsonEncode(inspection.toJson()),
  );
}
