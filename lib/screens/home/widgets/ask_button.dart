import 'package:flutter/material.dart';
import 'package:feliz/screens/chat/ask_screen.dart';

class AskButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AskButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('Ask Sun City AI'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AskScreen()),
        );
      },
    );
  }
}
