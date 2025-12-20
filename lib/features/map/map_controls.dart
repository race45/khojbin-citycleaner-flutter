import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  final VoidCallback onMyLocationTap;
  final VoidCallback onSearchTap;
  final double selectedRadiusKm;
  final ValueChanged<double> onRadiusChanged;

  const MapControls({
    super.key,
    required this.onMyLocationTap,
    required this.onSearchTap,
    required this.selectedRadiusKm,
    required this.onRadiusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "my_location",
          onPressed: onMyLocationTap,
          child: const Icon(Icons.my_location),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: "search",
          onPressed: onSearchTap,
          child: const Icon(Icons.search),
        ),
        const SizedBox(height: 16),

        _radiusChip("100m", 0.1),
        const SizedBox(height: 6),
        _radiusChip("500m", 0.5),
        const SizedBox(height: 6),
        _radiusChip("1km", 1.0),
      ],
    );
  }

  Widget _radiusChip(String label, double value) {
    final isSelected = selectedRadiusKm == value;

    return GestureDetector(
      onTap: () => onRadiusChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
