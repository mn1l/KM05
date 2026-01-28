import 'dart:convert';

import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic> json);

final apiBaseUrl = 'http://192.168.178.42:8080';

// Get single T object from Url
Future<T> get<T>(String url, FromJson<T> fromJson) async {
  TokenService tokenService = TokenService();

  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${await tokenService.getToken()}'},
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed: ${response.statusCode}');
  }

  final Map<String, dynamic> decodedBody =
      jsonDecode(response.body) as Map<String, dynamic>;

  return fromJson(decodedBody);
}

// Get list of T objects from Url
Future<List<T>> getList<T>(String url, FromJson<T> fromJson) async {
  TokenService tokenService = TokenService();

  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${await tokenService.getToken()}'},
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed: ${response.statusCode}');
  }

  final List<dynamic> decoded = jsonDecode(response.body);

  return decoded.map((json) => fromJson(json as Map<String, dynamic>)).toList();
}

// Patch url with jsonBody
Future<T> patch<T>(String url, FromJson<T> fromJson, String jsonBody) async {
  TokenService tokenService = TokenService();

  final response = await http.patch(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${await tokenService.getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonBody,
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed: ${response.statusCode}');
  }

  final Map<String, dynamic> decodedBody =
      jsonDecode(response.body) as Map<String, dynamic>;

  return fromJson(decodedBody);
}

// Post jsonBody at Url
Future<T> post<T>(String url, FromJson<T> fromJson, String jsonBody) async {
  TokenService tokenService = TokenService();

  print(jsonBody);
  print(url);

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer ${await tokenService.getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonBody,
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed: ${response.statusCode} Body: ${response.body}');
  }

  final Map<String, dynamic> decodedBody =
      jsonDecode(response.body) as Map<String, dynamic>;

  return fromJson(decodedBody);
}
