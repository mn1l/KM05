import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class FilterSection extends StatelessWidget {
  final String searchQuery;
  final String selectedFuel;
  final String selectedBody;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFuelChanged;
  final ValueChanged<String> onBodyChanged;

  const FilterSection({
    super.key,
    required this.searchQuery,
    required this.selectedFuel,
    required this.selectedBody,
    required this.onSearchChanged,
    required this.onFuelChanged,
    required this.onBodyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Zoek merk of model...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  _buildChip('Alle', selectedFuel, onFuelChanged),
                  _buildChip('Benzine', selectedFuel, onFuelChanged),
                  _buildChip('Diesel', selectedFuel, onFuelChanged),
                  _buildChip('Hybride', selectedFuel, onFuelChanged),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  _buildChip('Alle', selectedBody, onBodyChanged),
                  _buildChip('Sedan', selectedBody, onBodyChanged),
                  _buildChip('SUV', selectedBody, onBodyChanged),
                  _buildChip('Stationwagon', selectedBody, onBodyChanged),
                  _buildChip('Truck', selectedBody, onBodyChanged),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(
    String label,
    String current,
    ValueChanged<String> onSelect,
  ) {
    final bool isSelected = label == current;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(label),
      selectedColor: AppColors.darkBlue,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.darkBlue.withOpacity(0.1)),
      ),
    );
  }
}
