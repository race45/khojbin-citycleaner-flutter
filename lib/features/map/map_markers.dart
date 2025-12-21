import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

List<Marker> buildMarkersForBins({
  required List<LatLng> bins,
  required LatLng? selectedBin,
  required Function(LatLng) onBinTap,
}) {
  return bins.map((binLatLng) {
    final bool isSelected = selectedBin == binLatLng;

    return Marker(
      point: binLatLng,
      width: isSelected ? 48 : 40,
      height: isSelected ? 48 : 40,
      child: GestureDetector(
        onTap: () => onBinTap(binLatLng),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.red,
            shape: BoxShape.circle,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.blue.withAlpha(80),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }).toList();
}
