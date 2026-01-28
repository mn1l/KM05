import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:carsmeelien/config/api_keys.dart';

class MapService {
  static Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/foot-walking');
    
    final response = await http.post(
      url,
      headers: {
        'Authorization': ApiKeys.openRouteServiceKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "coordinates": [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude],
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['routes'] == null || data['routes'].isEmpty) return [];
      
      final encodedPolyline = data['routes'][0]['geometry'] as String;
      final polylinePoints = PolylinePoints().decodePolyline(encodedPolyline);

      return polylinePoints.map((p) => LatLng(p.latitude, p.longitude)).toList();
    }
    return [];
  }
}