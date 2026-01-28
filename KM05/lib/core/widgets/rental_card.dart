import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/navigation_page.dart';
import 'package:carsmeelien/pages/rent/ongoing_page.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/utils/formatters.dart';
import 'package:carsmeelien/core/widgets/card_image.dart';

class RentalCard extends StatelessWidget {
  final Rental rental;
  final double? width;
  final double? height;
  final double imageWidth;

  const RentalCard({
    super.key,
    required this.rental,
    this.width,
    this.height,
    this.imageWidth = 100,
  });

  void handleNavigate(BuildContext context) {
    Widget? page = switch (rental.state) {
      "RESERVED" || "PICKUP" => NavigationPage(rental: rental),
      "ACTIVE" => OngoingPage(rental: rental),
      _ => null,
    };

    if (page != null && rental.isStartingToday) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isActiveToday = rental.isStartingToday;

    Widget card = Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              CarImage(
                base64String: rental.car?.picture,
                width: imageWidth,
                height: height,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${rental.car?.brand} ${rental.car?.model} ${rental.car?.modelYear}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                      _buildInfoRow(Icons.euro, '${rental.totalPrice.toStringAsFixed(2)} totaal'),
                      const SizedBox(height: 3),
                      _buildInfoRow(Icons.people, '${rental.car?.nrOfSeats} personen'),
                      const SizedBox(height: 3),
                      _buildInfoRow(
                        Icons.calendar_today, 
                        '${AppFormatters.date(rental.fromDate)} - ${AppFormatters.date(rental.toDate)}'
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: RentalTheme.getStateColor(rental.state),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                rental.stateLabel,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );

    if (!isActiveToday) {
      card = Opacity(opacity: 0.5, child: card);
    }

    return _wrapInInkWell(context, card, isActiveToday);
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _wrapInInkWell(BuildContext context, Widget card, bool enabled) {
    final ink = InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: enabled ? () => handleNavigate(context) : null,
      child: card,
    );
    return width != null ? SizedBox(width: width, child: ink) : ink;
  }
}