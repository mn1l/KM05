import 'dart:convert';

import 'package:carsmeelien/models/inspection.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/inspections';

Future<Inspection> postInspection(Inspection inspection) async {
  TokenService tokenService = TokenService();

  final Map<String, dynamic> data = inspection.toJson();
  data.remove('id');

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await tokenService.getToken()}',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed to post inspection: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Inspection.fromJson(decoded);
}
