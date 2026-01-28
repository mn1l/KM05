import 'package:carsmeelien/core/utils/formatters.dart';
import 'package:carsmeelien/core/widgets/car_image.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';
import 'package:carsmeelien/pages/rent/widgets/car_info_card.dart';
import 'package:carsmeelien/pages/rent/widgets/expandable_sections.dart';

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

  int get _rentalDays => _selectedDateRange.duration.inDays;
  int get _totalPrice => _rentalDays * (widget.car.price);
  List<DateTime> _reservedDates = [];

  @override
  void initState() {
    super.initState();
    _loadReservedDates();
  }

  Future<void> _loadReservedDates() async {
    final dates = await getCarAvailableDates(widget.car.id);
    setState(() {
      _reservedDates = dates;
    });
  }

  // Date picker geeft een bug als ik date2 en date3 arguments weg laat.
  bool _isDateSelectable(DateTime day, DateTime? date2, DateTime? date3) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);

    return !_reservedDates.any(
      (blockedDate) =>
          blockedDate.year == normalizedDay.year &&
          blockedDate.month == normalizedDay.month &&
          blockedDate.day == normalizedDay.day,
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _selectedDateRange,
      selectableDayPredicate: _isDateSelectable,
      builder: (context, child) => Theme(
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.darkBlue)),
        child: child!,
      ),
    );
    if (picked != null) {
      bool hasReservedDateInRange = false;

      for (int i = 0; i <= picked.duration.inDays; i++) {
        DateTime dayToCheck = picked.start.add(Duration(days: i));

        if (!_isDateSelectable(dayToCheck, null, null)) {
          hasReservedDateInRange = true;
          break;
        }
      }

      if (hasReservedDateInRange) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Helaas, deze periode bevat dagen die al gereserveerd zijn.',
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else {
        setState(() => _selectedDateRange = picked);
      }
    }
  }

  void _handleRental() {
    if (_rentalDays < 1) return;
    createRental(_selectedDateRange, widget.car);

    Navigator.pop(context);
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            StepIndicator(currentStep: 0),
            const SizedBox(height: 12),

            Text(
              '${widget.car.brand} ${widget.car.model}',
              style: AppTextStyles.sectionHeader.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),

            CarImage(
              base64String: widget.car.picture,
              height: 160,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
            ),

            const SizedBox(height: 12),
            CarInfoCard(car: widget.car),

            if ((widget.car.inspections?.isNotEmpty ?? false) ||
                (widget.car.repairs?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 8),
              ExpandableSections(car: widget.car),
            ],

            const SizedBox(height: 16),

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
                            '${AppFormatters.shortDate(_selectedDateRange.start)} - ${AppFormatters.shortDate(_selectedDateRange.end)}',
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
                  ...[
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
              height: 50, 
              child: ElevatedButton(
                onPressed: _handleRental,
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
