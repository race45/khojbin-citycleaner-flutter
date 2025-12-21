import 'package:flutter/material.dart';
import 'directions_bottom_sheet.dart';

class TransportModeCard extends StatelessWidget {
  final TransportMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  const TransportModeCard({
  super.key,
  required this.mode,
  required this.isSelected,
  required this.onTap,
});


  IconData get _icon {
    switch (mode) {
      case TransportMode.walk:
        return Icons.directions_walk;
      case TransportMode.bike:
        return Icons.directions_bike;
      case TransportMode.car:
        return Icons.directions_car;
    }
  }

  String get _label {
    switch (mode) {
      case TransportMode.walk:
        return 'Walk';
      case TransportMode.bike:
        return 'Bike';
      case TransportMode.car:
        return 'Car';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(38),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icon,
              size: 22,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            const SizedBox(height: 4),
            Text(
              _label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
