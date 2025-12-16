import 'package:flutter/material.dart';

class ColourButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final int durationGiven; // In milliseconds
  final bool isHighlighted;
  final VoidCallback onTap;

  const ColourButton({
    super.key,
    required this.color,
    required this.icon,
    required this.durationGiven,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: durationGiven),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 15,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Icon(
            icon,
            color: isHighlighted ? Colors.white : Colors.black.withOpacity(.25),
            size: 100,
            shadows: [
              Shadow(
                color: isHighlighted
                    ? Colors.white
                    : Colors.black.withOpacity(.25),
                blurRadius: isHighlighted ? 4 : 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

