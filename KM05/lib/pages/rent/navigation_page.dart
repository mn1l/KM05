import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/core/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:carsmeelien/config/api_keys.dart';

class NavigationPage extends StatefulWidget {
  final Car? car;

  const NavigationPage({super.key, this.car});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final MapController _mapController = MapController();
  LatLng? _userLocation;
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_userLocation != null && widget.car != null) {
        final carLatLng = LatLng(widget.car!.latitude, widget.car!.longitude);
        final center = LatLng(
          (_userLocation!.latitude + carLatLng.latitude) / 2,
          (_userLocation!.longitude + carLatLng.longitude) / 2,
        );
        _mapController.move(center, 17.0);

        final route = await fetchRoute(_userLocation!, carLatLng);
        setState(() {
          _routePoints = route;
        });
      }
    });
  }


  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    final url =
        Uri.parse('https://api.openrouteservice.org/v2/directions/foot-walking');
    final body = jsonEncode({
      "coordinates": [
        [start.longitude, start.latitude],
        [end.longitude, end.latitude],
      ]
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': ApiKeys.openRouteServiceKey,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['routes'] == null || data['routes'].isEmpty) {
        throw Exception('No route found in ORS response');
      }

      final encodedPolyline = data['routes'][0]['geometry'] as String;

      final polylinePoints = PolylinePoints().decodePolyline(encodedPolyline);

      return polylinePoints
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();
    } else {
      throw Exception('Failed to fetch route: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final carLatLng = widget.car != null
        ? LatLng(widget.car!.latitude, widget.car!.longitude)
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation')),
      body: _userLocation == null || carLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _userLocation!,
                initialZoom: 17.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.carsmeelien',
                ),
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        color: AppColors.primary,
                        strokeWidth: 4,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _userLocation!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.my_location,
                        color: AppColors.darkBlue,
                        size: 40,
                      ),
                    ),
                    Marker(
                      point: carLatLng,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.directions_car,
                        color: AppColors.darkYellow,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
