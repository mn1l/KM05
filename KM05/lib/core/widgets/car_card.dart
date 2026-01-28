import 'package:carsmeelien/core/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/core/widgets/car_image.dart';
import 'package:carsmeelien/pages/rent/info_page.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final double? width;
  final double? height;
  final double imageWidth;
  final VoidCallback? onFavoriteChange;

  const CarCard({
    super.key,
    required this.car,
    this.width,
    this.height,
    this.imageWidth = 100,
    required this.onFavoriteChange,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CarImage(
                base64String: car.picture,
                width: imageWidth,
                height: height,
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: FavoriteButton(car: car, onChange: onFavoriteChange),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.brand} ${car.model} ${car.modelYear}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.euro, size: 16, color: AppColors.darkBlue),
                      const SizedBox(width: 4),
                      Text(
                        '${car.price} per dag',
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Max ${car.nrOfSeats} personen',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return _wrapInInkWell(context, card);
  }

  Widget _wrapInInkWell(BuildContext context, Widget card) {
    final ink = InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InfoPage(car: car)),
      ),
      child: card,
    );

    return width != null ? SizedBox(width: width, child: ink) : ink;
  }
}
