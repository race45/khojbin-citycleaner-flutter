import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

List<Marker> buildMarkersForBins(
  List<LatLng> bins,
  Function(LatLng) onBinTap,
) {
  return bins.map((binLatLng) {
    return Marker(
      point: binLatLng,
      width: 50,
      height: 50,
      child: GestureDetector(
        onTap: () => onBinTap(binLatLng),
        child: const Icon(
          Icons.delete,
          color: Colors.green,
          size: 36,
        ),
      ),
    );
  }).toList();
}
