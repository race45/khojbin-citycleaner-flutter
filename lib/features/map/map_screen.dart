import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/widgets/app_header.dart';
import 'map_controls.dart';
import 'map_markers.dart';
import '../bottom_sheets/bin_info_sheet.dart';
import '../sheets/add_bin_sheet.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(23.2599, 77.4126),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: buildMarkers(() {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (_) => BinInfoSheet(),
                  );
                }),
              ),
            ],
          ),

          const Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: AppHeader(),
          ),

          const Positioned(
            right: 16,
            bottom: 120,
            child: MapControls(),
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
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
