import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/navigation_page.dart';
import 'package:carsmeelien/pages/rent/ongoing_page.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/utils/formatters.dart';
import 'package:carsmeelien/core/widgets/car_image.dart';
import 'package:carsmeelien/pages/rent/rental_info_page.dart';

class RentalCard extends StatelessWidget {
  final Rental rental;
  final double? width;
  final double? height;
  final double imageWidth;
  final VoidCallback? onReturn;

  const RentalCard({
    super.key,
    required this.rental,
    this.width,
    this.height,
    this.imageWidth = 100,
    required this.onReturn,
  });

  void handleNavigate(BuildContext context) async {
    Widget? page;
    
    if (rental.state == "RESERVED") {
      page = RentalInfoPage(rental: rental);
    } else if (rental.state == "PICKUP") {
      page = NavigationPage(rental: rental);
    } else if (rental.state == "ACTIVE") {
      page = OngoingPage(rental: rental);
    }

    bool canOpen = (rental.state == "RESERVED") || rental.isStartingToday;

    if (page != null && canOpen) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page!),
      );
      onReturn?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isClickable = (rental.state == "RESERVED") || rental.isStartingToday;
    final bool isHistory = rental.state == "RETURNED";

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
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      Text(
                        '${rental.car?.brand} ${rental.car?.model}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      _buildInfoRow(Icons.euro, '${rental.totalPrice.toStringAsFixed(2)} totaal'),
                      _buildInfoRow(Icons.people, '${rental.car?.nrOfSeats} personen'),
                      _buildInfoRow(
                        Icons.calendar_month,
                        '${AppFormatters.shortDate(rental.fromDate)} - ${AppFormatters.shortDate(rental.toDate)}',
                        iconColor: AppColors.darkBlue,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (isHistory) {
      card = Opacity(opacity: 0.6, child: card);
    }

    return _wrapInInkWell(context, card, isClickable);
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor ?? Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: iconColor != null
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _wrapInInkWell(BuildContext context, Widget card, bool enabled) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: enabled ? () => handleNavigate(context) : null,
      child: width != null ? SizedBox(width: width, child: card) : card,
    );
  }
}
