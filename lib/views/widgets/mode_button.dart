import 'package:color_match/models/mode_option.dart';
import 'package:flutter/material.dart';
import 'package:color_match/views/widgets/colour_button.dart';

class ModeButton extends StatefulWidget {
  final ModeOption option;
  final double size;

  const ModeButton({super.key, required this.option, required this.size});

  @override
  State<ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<ModeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ColourButton(
              color: widget.option.color,
              icon: widget.option.icon,
              durationGiven: 180,
              isHighlighted: _isHovered,
              onTap: () {
                _isHovered = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => widget.option.builder()),
                );
              },
            ),
            Positioned(
              bottom: 8,
              child: IgnorePointer(
                child: Text(
                  widget.option.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

