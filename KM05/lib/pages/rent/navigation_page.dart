import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/core/theme.dart';

class NavigationPage extends StatefulWidget {
  final Car? car;

  const NavigationPage({super.key, this.car});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final MapController _mapController = MapController();
  LatLng? _userLocation;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_userLocation != null) {
        final carLatLng = LatLng(widget.car!.latitude, widget.car!.longitude);
        final center = LatLng(
          (_userLocation!.latitude + carLatLng.latitude) / 2,
          (_userLocation!.longitude + carLatLng.longitude) / 2,
        );
        _mapController.move(center, 17.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final carLatLng = LatLng(widget.car!.latitude, widget.car!.longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation')),
      body: _userLocation == null
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
