import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/main_page.dart';
import 'package:carsmeelien/services/auth/account.dart';
import 'package:carsmeelien/services/resource/customer.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';
import 'package:carsmeelien/pages/rent/widgets/car_info_card.dart';
import 'package:carsmeelien/pages/rent/widgets/expandable_sections.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class InfoPage extends StatefulWidget {
  final Car car;
  const InfoPage({super.key, required this.car});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  // Logic to calculate total days and price
  int get _rentalDays => _selectedDateRange.duration.inDays;
  int get _totalPrice => _rentalDays * (widget.car.price);

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _selectedDateRange,
      builder: (context, child) => Theme(
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.darkBlue)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDateRange = picked);
  }

  void _handleRental() {
    if (_rentalDays < 1) return;
    createRental(_selectedDateRange, widget.car);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ), // Reduced vertical padding
        child: Column(
          children: [
            StepIndicator(currentStep: 0),
            const SizedBox(height: 12), // Compact spacing

            Text(
              '${widget.car.brand} ${widget.car.model}',
              style: AppTextStyles.sectionHeader.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildImageWidget(
                widget.car,
                height: 160,
              ), // Smaller image height
            ),

            const SizedBox(height: 12),
            CarInfoCard(car: widget.car),

            // Smaller gap if sections exist
            if ((widget.car.inspections?.isNotEmpty ?? false) ||
                (widget.car.repairs?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 8),
              ExpandableSections(car: widget.car),
            ],

            const SizedBox(height: 16),

            // --- COMPACT DATE PICKER & PRICE CALCULATION ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.darkBlue.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _selectDateRange(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppColors.darkBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedDateRange == null
                                ? 'Kies data'
                                : '${DateFormat('dd MMM').format(_selectedDateRange!.start)} - ${DateFormat('dd MMM').format(_selectedDateRange!.end)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Wijzig',
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedDateRange != null) ...[
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Totaal ($_rentalDays dagen):',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          '€${_totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50, // Slightly shorter button
              child: ElevatedButton(
                onPressed: _selectedDateRange == null ? null : _handleRental,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Huren',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Update helper to accept height
Widget _buildImageWidget(Car car, {double height = 200}) {
  final picture = car.picture;
  if (picture.isEmpty) return _placeholderImage(car, height);
  try {
    final imageBytes = base64Decode(picture);
    return Image.memory(
      imageBytes,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
    );
  } catch (e) {
    return _placeholderImage(car, height);
  }
}

Widget _placeholderImage(Car car, double height) {
  return Container(
    width: double.infinity,
    height: height,
    color: AppColors.darkYellow,
    child: const Icon(Icons.directions_car, size: 48, color: Colors.white70),
  );
}

void createRental(DateTimeRange dateRange, Car car) async {
  final account = await getAccountDetails();

  final customer = await getMe();

  print(jsonEncode(customer));

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final rental = Rental(
    id: 0,
    code: "long",
    longitude: car.longitude,
    latitude: car.latitude,
    fromDate: formatter.format(dateRange.start),
    toDate: formatter.format(dateRange.end),
    state: "RESERVED",
    inspections: [],
    customer: customer,
    car: car,
  );

  final savedRental = await postRental(rental);
  await updateRentalState(savedRental.id, "RESERVED");
}
