import 'dart:async';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/game_state.dart';
import 'package:color_match/viewmodels/base_game_viewmodel.dart';

class ClassicGameViewModel extends BaseGameViewModel {
  ClassicGameViewModel()
      : super(GameState(palette: GamePalette.classic)) {
    startGame();
  }

  @override
  void startGame() {
    updateState(GameState(
      sequence: [],
      playerMoves: [],
      score: 0,
      gameOver: false,
      showingSequence: false,
      palette: GamePalette.classic,
    ));
    nextRound();
  }

  @override
  void nextRound() {
    final newSequence = List<int>.from(state.sequence)
      ..add(getRandomColorIndex());
    updateState(state.copyWith(
      sequence: newSequence,
      playerMoves: [],
      showingSequence: true,
    ));
    playSequence();
  }

  @override
  Future<void> playSequence() async {
    await Future.delayed(const Duration(seconds: 1));

    for (int i = 0; i < state.sequence.length; i++) {
      int colorIndex = state.sequence[i];
      updateState(state.copyWith(highlightedIndex: colorIndex));
      await playSound(colorIndex);
      await Future.delayed(const Duration(milliseconds: 500));
      updateState(state.copyWith(highlightedIndex: null));
      await Future.delayed(const Duration(milliseconds: 250));
    }
    updateState(state.copyWith(showingSequence: false));
  }

  @override
  Future<void> onColorTap(int index) async {
    if (state.gameOver || state.showingSequence) return;

    updateState(state.copyWith(tappedIndex: index));
    await playSound(index);
    await Future.delayed(const Duration(milliseconds: 200));
    updateState(state.copyWith(tappedIndex: null));

    final newPlayerMoves = List<int>.from(state.playerMoves)..add(index);
    updateState(state.copyWith(playerMoves: newPlayerMoves));

    if (newPlayerMoves[newPlayerMoves.length - 1] !=
        state.sequence[newPlayerMoves.length - 1]) {
      updateState(state.copyWith(gameOver: true));
      return;
    }

    if (newPlayerMoves.length == state.sequence.length) {
      updateState(state.copyWith(score: state.score + 1));
      nextRound();
    }
  }
}

