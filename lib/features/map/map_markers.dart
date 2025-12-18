import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

List<Marker> buildMarkers(VoidCallback onTap) {
  return [
    Marker(
      width: 40,
      height: 40,
      point: LatLng(23.2599, 77.4126),
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.location_pin,
          size: 40,
          color: Colors.red,
        ),
      ),
    ),
  ];
}
