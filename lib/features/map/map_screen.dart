import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:citycleaner/core/widgets/app_header.dart';
import 'package:citycleaner/core/services/location_service.dart';
import 'package:citycleaner/core/services/geocoding_service.dart';
import 'package:citycleaner/core/utils/distance_utils.dart';
import 'package:citycleaner/core/utils/polyline_utils.dart';
import 'package:citycleaner/core/widgets/directions_bottom_sheet.dart';

import 'map_controls.dart';
import 'map_markers.dart';
import 'package:citycleaner/features/sheets/add_bin_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  List<LatLng> _routePoints = [];
  LatLng? _userLocation;

  double _selectedRadiusKm = 0.5;

  /// ⭐ NEW: selected marker
  LatLng? _selectedBin;

  final List<LatLng> _allBins = [
    LatLng(23.2610, 77.4140),
    LatLng(23.2580, 77.4100),
    LatLng(23.2650, 77.4200),
  ];

  // -------------------------------
  // MY LOCATION
  // -------------------------------
  Future<void> _goToMyLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (!mounted) return;

      final userLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _userLocation = userLatLng;
        _routePoints = [];
        _selectedBin = null;
      });

      _mapController.move(userLatLng, 16);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // -------------------------------
  // NAME SEARCH
  // -------------------------------
  void _openSearchDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Search Location"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter place name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final query = controller.text.trim();
              if (query.isEmpty) return;

              Navigator.pop(context);

              final result = await GeocodingService.searchByName(query);
              if (!mounted) return;

              if (result != null) {
                setState(() {
                  _userLocation = result;
                  _selectedBin = null;
                });
                _mapController.move(result, 15);
              }
            },
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // BIN TAP (UPDATED)
  // -------------------------------
  Future<void> _onBinTapped(LatLng binLatLng) async {
    if (_userLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable My Location to get directions'),
        ),
      );

      setState(() {
        _selectedBin = binLatLng;
        _routePoints.clear();
      });

      return;
    }

    final distanceKm = DistanceUtils.calculateDistance(
      _userLocation!.latitude,
      _userLocation!.longitude,
      binLatLng.latitude,
      binLatLng.longitude,
    );

    final route = PolylineUtils.buildStraightRoute(_userLocation!, binLatLng);

    setState(() {
      _selectedBin = binLatLng;
      _routePoints = route;
    });

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds.fromPoints(route),
        padding: const EdgeInsets.all(80),
      ),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DirectionsBottomSheet(distanceKm: distanceKm),
    );
  }

  // -------------------------------
  // FILTERED BINS
  // -------------------------------
  List<LatLng> get _visibleBins {
    if (_userLocation == null) return _allBins;

    return _allBins.where((bin) {
      final distance = DistanceUtils.calculateDistance(
        _userLocation!.latitude,
        _userLocation!.longitude,
        bin.latitude,
        bin.longitude,
      );
      return distance <= _selectedRadiusKm;
    }).toList();
  }

  // -------------------------------
  // UI
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(23.2599, 77.4126),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.khojbin',
              ),

              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 5,
                      color: Colors.blue.withAlpha(230), // ~90% opacity
                      strokeCap: StrokeCap.round,
                      strokeJoin: StrokeJoin.round,
                    ),
                  ],
                ),

              MarkerLayer(
                markers: buildMarkersForBins(
                  bins: _visibleBins,
                  selectedBin: _selectedBin,
                  onBinTap: _onBinTapped,
                ),
              ),
            ],
          ),

          const Positioned(top: 40, left: 16, right: 16, child: AppHeader()),

          Positioned(
            right: 16,
            bottom: 120,
            child: MapControls(
              onMyLocationTap: _goToMyLocation,
              onSearchTap: _openSearchDialog,
              selectedRadiusKm: _selectedRadiusKm,
              onRadiusChanged: (value) {
                setState(() {
                  _selectedRadiusKm = value;
                  _selectedBin = null;
                  _routePoints.clear();
                });
              },
            ),
          ),

          Positioned(
            right: 16,
            bottom: 40,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => AddBinSheet(),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
