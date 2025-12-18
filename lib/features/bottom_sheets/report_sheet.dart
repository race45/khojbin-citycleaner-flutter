import 'package:flutter/material.dart';

class ReportSheet extends StatelessWidget {
  const ReportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _ReportTile("No Bin Found Here"),
        _ReportTile("Bin is Damaged"),
        _ReportTile("Bin is Overflowing"),
        _ReportTile("Bin is Inside Private Property"),
      ],
    );
  }
}

class _ReportTile extends StatelessWidget {
  final String title;

  const _ReportTile(this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
