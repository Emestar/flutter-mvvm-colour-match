import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_match/viewmodels/infinite_game_viewmodel.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/constants.dart';
import 'package:color_match/views/widgets/gradient_background.dart';
import 'package:color_match/views/widgets/palette_board.dart';
import 'package:color_match/views/widgets/difficulty_selection.dart';

class GameModeInfinity extends StatefulWidget {
  const GameModeInfinity({super.key});

  @override
  State<GameModeInfinity> createState() => _GameModeInfinityState();
}

class _GameModeInfinityState extends State<GameModeInfinity> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InfiniteGameViewModel(),
      child: Consumer<InfiniteGameViewModel>(
        builder: (context, viewModel, child) {
          final state = viewModel.state;

          // Show snackbar for mistakes
          if (viewModel.mistakes > 0 &&
              state.playerMoves.isEmpty &&
              !state.showingSequence) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error #${viewModel.mistakes} - try again!"),
                  duration: const Duration(seconds: 1),
                ),
              );
            });
          }

          return GradientBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                foregroundColor: ktextcolor,
                backgroundColor: kfourcolor,
                title: const Text('Infinity Mode'),
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
                              "Completed sequences: ${state.score}",
                              style: const TextStyle(
                                fontSize: 28,
                                color: ktextcolor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Mistakes: ${viewModel.mistakes}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
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
}
