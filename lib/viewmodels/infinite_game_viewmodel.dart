import 'dart:async';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/game_state.dart';
import 'package:color_match/viewmodels/base_game_viewmodel.dart';

class InfiniteGameViewModel extends BaseGameViewModel {
  int _mistakes = 0;

  InfiniteGameViewModel() : super(GameState()) {
    // Palette will be set by the view
  }

  int get mistakes => _mistakes;

  void setPalette(GamePalette palette) {
    updateState(state.copyWith(palette: palette));
    startGame();
  }

  void resetPalette() {
    updateState(
      GameState(
        sequence: [],
        playerMoves: [],
        score: 0,
        showingSequence: false,
        palette: null,
      ),
    );
  }

  @override
  void startGame() {
    if (state.palette == null) return;
    _mistakes = 0;
    updateState(
      GameState(
        sequence: [],
        playerMoves: [],
        score: 0,
        showingSequence: false,
        palette: state.palette,
      ),
    );
    nextRound();
  }

  @override
  void nextRound() {
    if (state.palette == null) return;
    final newSequence = List<int>.from(state.sequence)
      ..add(getRandomColorIndex());
    updateState(
      state.copyWith(
        sequence: newSequence,
        playerMoves: [],
        showingSequence: true,
      ),
    );
    playSequence();
  }

  @override
  Future<void> playSequence() async {
    await Future.delayed(const Duration(milliseconds: 900));

    for (final colorIndex in state.sequence) {
      updateState(state.copyWith(highlightedIndex: colorIndex));
      await playSound(colorIndex);
      await Future.delayed(const Duration(milliseconds: 420));
      updateState(state.copyWith(highlightedIndex: null));
      await Future.delayed(const Duration(milliseconds: 200));
    }
    updateState(state.copyWith(showingSequence: false));
  }

  @override
  Future<void> onColorTap(int index) async {
    if (state.showingSequence) return;

    updateState(state.copyWith(tappedIndex: index));
    await playSound(index);
    await Future.delayed(const Duration(milliseconds: 180));
    updateState(state.copyWith(tappedIndex: null));

    final newPlayerMoves = List<int>.from(state.playerMoves)..add(index);
    updateState(state.copyWith(playerMoves: newPlayerMoves));

    if (newPlayerMoves.last != state.sequence[newPlayerMoves.length - 1]) {
      _mistakes++;
      updateState(state.copyWith(playerMoves: [], showingSequence: true));
      notifyListeners();
      await playSequence();
      return;
    }

    if (newPlayerMoves.length == state.sequence.length) {
      updateState(state.copyWith(score: state.score + 1));
      nextRound();
    }
  }
}
