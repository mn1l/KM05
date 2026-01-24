import 'dart:convert';

import 'package:carsmeelien/models/account.dart';
import 'package:carsmeelien/models/customer.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/AM/me';

/*
{
    "id": 1500,
    "nr": null,
    "lastName": "hekman",
    "firstName": "meelien",
    "from": null,
    "systemUser": {
        "createdBy": "anonymousUser",
        "createdDate": "2026-01-24T13:22:08.928363Z",
        "lastModifiedBy": "anonymousUser",
        "lastModifiedDate": "2026-01-24T13:22:27.698740Z",
        "id": 1050,
        "login": "meelien",
        "firstName": "meelien",
        "lastName": "hekman",
        "email": "mlhekman@gmail.com",
        "activated": true,
        "langKey": "NL",
        "imageUrl": null,
        "resetDate": null
    },
    "rentals": [],
    "location": null
}*/

Future<Customer> getMe() async {
  TokenService tokenService = TokenService();

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {'Authorization': 'Bearer ${await tokenService.getToken()}'},
  );

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Customer.fromJson(decoded);
}
