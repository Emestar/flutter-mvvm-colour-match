import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_match/viewmodels/time_game_viewmodel.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/constants.dart';
import 'package:color_match/views/widgets/gradient_background.dart';
import 'package:color_match/views/widgets/palette_board.dart';
import 'package:color_match/views/widgets/difficulty_selection.dart';

class GameModeTime extends StatefulWidget {
  const GameModeTime({super.key});

  @override
  State<GameModeTime> createState() => _GameModeTimeState();
}

class _GameModeTimeState extends State<GameModeTime> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeGameViewModel(),
      child: Consumer<TimeGameViewModel>(
        builder: (context, viewModel, child) {
          final state = viewModel.state;

          // Show game over dialog when gameOver becomes true
          if (state.gameOver && !_dialogShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && !_dialogShown) {
                _dialogShown = true;
                final reason = viewModel.timeLeft <= 0
                    ? "Time's up!"
                    : "Incorrect sequence.";
                _showGameOverDialog(context, viewModel, reason);
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
                backgroundColor: kthreecolor,
                title: const Text('Time Mode'),
                actions: [
                  IconButton(
                    tooltip: 'Switch mode',
                    onPressed: () => viewModel.resetPalette(),
                    icon: const Icon(Icons.swap_horiz),
                  ),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: state.palette == null
                      ? DifficultySelection(
                          onDifficultySelected: (palette) {
                            viewModel.setPalette(palette);
                          },
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mode: ${state.palette!.config.shortLabel}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Score: ${viewModel.score.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 28,
                                color: ktextcolor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.showingSequence
                                  ? "Watch the sequence..."
                                  : "Time remaining: ${viewModel.timeLeft} s",
                              style: TextStyle(
                                color: state.showingSequence
                                    ? Colors.white70
                                    : ktextcolor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 24),
                            PaletteBoard(
                              palette: state.palette!,
                              highlightedIndex: state.highlightedIndex,
                              tappedIndex: state.tappedIndex,
                              onTap: viewModel.onColorTap,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: viewModel.startGame,
                              child: const Text("Restart"),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showGameOverDialog(
    BuildContext context,
    TimeGameViewModel viewModel,
    String reason,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Score: ${viewModel.score.toStringAsFixed(2)}\n$reason"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _dialogShown = false;
              viewModel.startGame();
            },
            child: const Text("Play Again"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _dialogShown = false;
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
