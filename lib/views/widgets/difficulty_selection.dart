import 'package:flutter/material.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/constants.dart';
import 'package:color_match/views/widgets/colour_button.dart';

class DifficultySelection extends StatefulWidget {
  final Function(GamePalette) onDifficultySelected;

  const DifficultySelection({super.key, required this.onDifficultySelected});

  @override
  State<DifficultySelection> createState() => _DifficultySelectionState();
}

class _DifficultySelectionState extends State<DifficultySelection> {
  bool _classicHovered = false;
  bool _hardHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose a difficulty",
            style: TextStyle(
              color: ktextcolor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              // Classic button
              MouseRegion(
                onEnter: (_) => setState(() => _classicHovered = true),
                onExit: (_) => setState(() => _classicHovered = false),
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColourButton(
                        color: konecolor,
                        icon: Icons.tag_faces_outlined,
                        durationGiven: 180,
                        isHighlighted: _classicHovered,
                        onTap: () =>
                            widget.onDifficultySelected(GamePalette.classic),
                      ),
                      Positioned(
                        bottom: 8,
                        child: IgnorePointer(
                          child: Text(
                            'Classic',
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
              ),
              // Hard button
              MouseRegion(
                onEnter: (_) => setState(() => _hardHovered = true),
                onExit: (_) => setState(() => _hardHovered = false),
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColourButton(
                        color: ktwocolor,
                        icon: Icons.add_reaction_outlined,
                        durationGiven: 180,
                        isHighlighted: _hardHovered,
                        onTap: () =>
                            widget.onDifficultySelected(GamePalette.hard),
                      ),
                      Positioned(
                        bottom: 8,
                        child: IgnorePointer(
                          child: Text(
                            'Hard',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
