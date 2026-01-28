import 'package:carsmeelien/core/utils/location_helper.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/ongoing_page.dart';
import 'package:carsmeelien/pages/rent/widgets/map_card.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';
import 'package:carsmeelien/services/map_service.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:carsmeelien/core/theme.dart';

class NavigationPage extends StatefulWidget {
  final Rental rental;

  const NavigationPage({super.key, required this.rental});

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
    updateRentalState(widget.rental.id, "PICKUP");
    _setupNavigation();
  }

  Future<void> _setupNavigation() async {
    try {
      final userLatLng = await LocationHelper.getCurrentLocation();

      setState(() => _userLocation = userLatLng);

      if (widget.rental.car != null) {
        final carLatLng = LatLng(
          widget.rental.car!.latitude,
          widget.rental.car!.longitude,
        );

        final route = await MapService.fetchRoute(userLatLng, carLatLng);

        if (mounted) {
          setState(() => _routePoints = route);
          _mapController.move(userLatLng, 17.0);
        }
      }
    } catch (e) {
      debugPrint("Navigation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userLocation == null)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Auto', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Huren', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepIndicator(currentStep: 1),
            const SizedBox(height: 12),

            Text(
              'Navigeer naar de auto',
              style: AppTextStyles.sectionHeader.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: MapCard(
                controller: _mapController,
                userLocation: _userLocation!,
                carLocation: LatLng(
                  widget.rental.car!.latitude,
                  widget.rental.car!.longitude,
                ),
                routePoints: _routePoints,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.darkBlue.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.darkBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Volg de route op de kaart om bij de ${widget.rental.car?.brand} te komen.",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final rental = await updateRentalState(
                    widget.rental.id,
                    "ACTIVE",
                  );
                  if (mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => OngoingPage(rental: rental),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Aangekomen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
