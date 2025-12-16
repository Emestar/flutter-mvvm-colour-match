import 'package:flutter/material.dart';

class ModeOption {
  final String label;
  final Color color;
  final IconData icon;
  final Widget Function() builder;

  const ModeOption({
    required this.label,
    required this.color,
    required this.icon,
    required this.builder,
  });
}

