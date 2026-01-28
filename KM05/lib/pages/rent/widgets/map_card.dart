import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:carsmeelien/core/theme.dart';

class MapCard extends StatelessWidget {
  final MapController controller;
  final LatLng userLocation;
  final LatLng carLocation;
  final List<LatLng> routePoints;

  const MapCard({
    super.key,
    required this.controller,
    required this.userLocation,
    required this.carLocation,
    required this.routePoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBlue.withOpacity(0.1)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(initialCenter: userLocation, initialZoom: 17.0),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.carsmeelien',
            ),
            if (routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: AppColors.darkBlue,
                    strokeWidth: 4,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                Marker(
                  point: userLocation,
                  child: const Icon(
                    Icons.my_location,
                    color: AppColors.darkBlue,
                  ),
                ),
                Marker(
                  point: carLocation,
                  child: const Icon(
                    Icons.directions_car,
                    color: AppColors.darkYellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
