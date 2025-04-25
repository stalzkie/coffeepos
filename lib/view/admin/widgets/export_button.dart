import 'package:flutter/material.dart';

class ExportButton extends StatelessWidget {
  final String text;
  final bool isActivated;

  const ExportButton({
    super.key,
    required this.text,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (!isActivated ? 370 : 330),
      height: (!isActivated ? 70 : 50),
      decoration: BoxDecoration(
        color: (isActivated ? const Color.fromARGB(0, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255)),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.black),
      ),
      padding: EdgeInsets.zero,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}