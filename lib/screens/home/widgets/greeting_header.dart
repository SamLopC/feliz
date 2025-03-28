import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.primary;
    final Color textColor = Theme.of(context).appBarTheme.foregroundColor ?? Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.sunny, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            'Welcome to Sun City (El Paso)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your smart city companion 🌇',
            style: TextStyle(
              fontSize: 14,
              color: textColor.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
