import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        inactiveThumbColor: Colors.black,
      );
    }
  }
}