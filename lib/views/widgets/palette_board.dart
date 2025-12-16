import 'package:color_match/views/widgets/colour_button.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/constants.dart';
import 'package:flutter/material.dart';

class PaletteBoard extends StatelessWidget {
  final GamePalette palette;
  final int? highlightedIndex;
  final int? tappedIndex;
  final ValueChanged<int> onTap;
  final int? durationOverride;

  const PaletteBoard({
    super.key,
    required this.palette,
    required this.highlightedIndex,
    required this.tappedIndex,
    required this.onTap,
    this.durationOverride,
  });

  @override
  Widget build(BuildContext context) {
    final config = palette.config;
    final colors = config.colors;
    final duration = durationOverride ?? config.buttonDuration;

    return Wrap(
      spacing: config.spacing,
      runSpacing: config.runSpacing,
      alignment: WrapAlignment.center,
      children: List.generate(
        colors.length,
        (index) => ColourButton(
          color: colors[index],
          icon: icons[index],
          durationGiven: duration,
          isHighlighted: highlightedIndex == index || tappedIndex == index,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}

