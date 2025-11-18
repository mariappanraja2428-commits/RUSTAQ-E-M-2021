import 'package:flutter/material.dart';

class AreaButton extends StatelessWidget {
  final String areaName;
  final VoidCallback onTap;

  const AreaButton({super.key, required this.areaName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.blueAccent,
          ),
          child: Text(
            areaName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
