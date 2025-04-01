import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feliz/screens/chat/ask_screen.dart';

class AdaptiveAskButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AdaptiveAskButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton.filled(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.chat_bubble, size: 20),
            SizedBox(width: 8),
            Text('Ask Sun City AI'),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AskScreen()),
          );
        },
      );
    } else {
      return ElevatedButton.icon(
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('Ask Sun City AI'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
}