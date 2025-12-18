import 'package:flutter/material.dart';

class ShareSheet extends StatelessWidget {
  const ShareSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Share Location",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _ShareIcon(Icons.facebook, "Facebook"),
              _ShareIcon(Icons.camera_alt, "Instagram"),
              _ShareIcon(Icons.mail, "Email"),
              _ShareIcon(Icons.link, "Copy"),
              _ShareIcon(Icons.chat, "WhatsApp"),
              _ShareIcon(Icons.bluetooth, "Bluetooth"),
              _ShareIcon(Icons.share, "More"),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ShareIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
