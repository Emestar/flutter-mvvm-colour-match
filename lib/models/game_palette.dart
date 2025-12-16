import 'package:flutter/material.dart';
import 'package:color_match/models/constants.dart';

enum GamePalette { classic, hard }

class GamePaletteConfig {
  final List<Color> colors;
  final Color appBarColor;
  final String label;
  final String shortLabel;
  final int buttonDuration;
  final double spacing;
  final double runSpacing;

  const GamePaletteConfig({
    required this.colors,
    required this.appBarColor,
    required this.label,
    required this.shortLabel,
    required this.buttonDuration,
    required this.spacing,
    required this.runSpacing,
  });
}

const Map<GamePalette, GamePaletteConfig> paletteConfigs = {
  GamePalette.classic: GamePaletteConfig(
    colors: colorsclassic,
    appBarColor: konecolor,
    label: 'Classic Mode',
    shortLabel: 'Classic',
    buttonDuration: 200,
    spacing: 30,
    runSpacing: 30,
  ),
  GamePalette.hard: GamePaletteConfig(
    colors: colorshard,
    appBarColor: ktwocolor,
    label: 'Hard Mode',
    shortLabel: 'Hard',
    buttonDuration: 100,
    spacing: 30,
    runSpacing: 30,
  ),
};

extension GamePaletteX on GamePalette {
  GamePaletteConfig get config => paletteConfigs[this]!;
}
