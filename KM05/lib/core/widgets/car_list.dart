import 'package:flutter/material.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';
import 'package:carsmeelien/core/theme.dart';

class CarListSection extends StatelessWidget {
  final List<Car> cars;
  final VoidCallback onFavoriteChange;

  const CarListSection({
    super.key,
    required this.cars,
    required this.onFavoriteChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Beschikbare Auto\'s', style: AppTextStyles.sectionHeader),
        const SizedBox(height: 12),
        if (cars.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text('Geen auto\'s gevonden met deze filters'),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cars.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return CarCard(
                car: cars[index],
                height: 100,
                imageWidth: 100,
                onFavoriteChange: onFavoriteChange,
              );
            },
          ),
      ],
    );
  }
}
