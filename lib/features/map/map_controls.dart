import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _btn(Icons.layers),
        const SizedBox(height: 10),
        _btn(Icons.my_location),
        const SizedBox(height: 10),
        _btn(Icons.settings),
      ],
    );
  }

  Widget _btn(IconData icon) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black),
    );
  }
}
