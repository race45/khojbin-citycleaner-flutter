import 'package:flutter/material.dart';

class AddBinSheet extends StatefulWidget {
  const AddBinSheet({super.key});

  @override
  State<AddBinSheet> createState() => _AddBinSheetState();
}

class _AddBinSheetState extends State<AddBinSheet> {
  bool isNotPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Bin Here",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: "Landmark",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: isNotPrivate,
                  onChanged: (val) {
                    setState(() {
                      isNotPrivate = val ?? false;
                    });
                  },
                ),
                const Text("Not a private property"),
              ],
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
