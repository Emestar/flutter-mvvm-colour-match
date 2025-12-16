import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_match/viewmodels/hard_game_viewmodel.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/constants.dart';
import 'package:color_match/views/widgets/gradient_background.dart';
import 'package:color_match/views/widgets/palette_board.dart';

class GameModeHard extends StatefulWidget {
  const GameModeHard({super.key});

  @override
  State<GameModeHard> createState() => _GameModeHardState();
}

class _GameModeHardState extends State<GameModeHard> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HardGameViewModel(),
      child: Consumer<HardGameViewModel>(
        builder: (context, viewModel, child) {
          final state = viewModel.state;
          final palette = viewModel.palette;

          // Show game over dialog when gameOver becomes true
          if (state.gameOver && !_dialogShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && !_dialogShown) {
                _dialogShown = true;
                _showGameOverDialog(context, viewModel, state.score);
              }
            });
          } else if (!state.gameOver) {
            _dialogShown = false;
          }

          return GradientBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                foregroundColor: ktextcolor,
                backgroundColor: palette.config.appBarColor,
                title: Text(palette.config.label),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score: ${state.score}",
                      style: const TextStyle(fontSize: 24, color: ktextcolor),
                    ),
                    const SizedBox(height: 10),
                    PaletteBoard(
                      palette: palette,
                      highlightedIndex: state.highlightedIndex,
                      tappedIndex: state.tappedIndex,
                      onTap: viewModel.onColorTap,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.startGame,
                      child: const Text("Restart"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showGameOverDialog(
      BuildContext context, HardGameViewModel viewModel, int score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("Your score: $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogShown = false;
                viewModel.startGame();
              },
              child: const Text("Restart"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogShown = false;
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

