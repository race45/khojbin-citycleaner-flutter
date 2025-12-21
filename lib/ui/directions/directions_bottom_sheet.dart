import 'package:flutter/material.dart';
import 'transport_mode_selector.dart';


enum TransportMode { walk, bike, car }

void showDirectionsBottomSheet(
  BuildContext context, {
  TransportMode selectedMode = TransportMode.walk,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return _DirectionsBottomSheet(
        selectedMode: selectedMode,
      );
    },
  );
}

class _DirectionsBottomSheet extends StatefulWidget {
  final TransportMode selectedMode;

  const _DirectionsBottomSheet({
    super.key,
  required this.selectedMode,
});

  @override
  State<_DirectionsBottomSheet> createState() =>
      _DirectionsBottomSheetState();
}

class _DirectionsBottomSheetState extends State<_DirectionsBottomSheet> {
  late TransportMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.selectedMode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Drag Handle ─────────────────────────────
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ─── Distance + ETA ──────────────────────────
          const Text(
            '0.5 km • 6 min walk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // ─── Transport Mode Selector ─────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: TransportMode.values.map((mode) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TransportModeCard(
                  mode: mode,
                  isSelected: _mode == mode,
                  onTap: () {
                    setState(() => _mode = mode);
                  },
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // ─── Start Navigation Button ─────────────────
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: null, // disabled for now (no route logic yet)
              icon: const Icon(Icons.navigation),
              label: const Text(
                'Start Navigation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.blue.withAlpha(102), // 40% opacity
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
