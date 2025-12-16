import 'dart:async';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/game_state.dart';
import 'package:color_match/viewmodels/base_game_viewmodel.dart';

class TimeGameViewModel extends BaseGameViewModel {
  Timer? _roundTimer;
  int _timeLeft = 0;
  int _roundDuration = 0;
  DateTime? _roundStartTime;
  double _score = 0;

  TimeGameViewModel() : super(GameState()) {
    // Palette will be set by the view
  }

  int get timeLeft => _timeLeft;
  double get score => _score;

  void setPalette(GamePalette palette) {
    updateState(state.copyWith(palette: palette));
    startGame();
  }

  void resetPalette() {
    _roundTimer?.cancel();
    updateState(
      GameState(
        sequence: [],
        playerMoves: [],
        score: 0,
        gameOver: false,
        showingSequence: false,
        palette: null,
      ),
    );
    _timeLeft = 0;
  }

  @override
  void startGame() {
    if (state.palette == null) return;
    _roundTimer?.cancel();
    _score = 0;
    updateState(
      GameState(
        sequence: [],
        playerMoves: [],
        gameOver: false,
        gameOverReason: null,
        showingSequence: false,
        palette: state.palette,
      ),
    );
    _timeLeft = 0;
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
    await Future.delayed(const Duration(milliseconds: 800));

    for (final colorIndex in state.sequence) {
      updateState(state.copyWith(highlightedIndex: colorIndex));
      await playSound(colorIndex);
      await Future.delayed(const Duration(milliseconds: 400));
      updateState(state.copyWith(highlightedIndex: null));
      await Future.delayed(const Duration(milliseconds: 180));
    }
    updateState(state.copyWith(showingSequence: false));
    _startRoundTimer();
  }

  void _startRoundTimer() {
    _roundTimer?.cancel();
    final base = state.palette == GamePalette.hard ? 1 : 2;
    final seconds = base + state.sequence.length;

    _timeLeft = seconds;
    _roundDuration = seconds;
    _roundStartTime = DateTime.now();

    _roundTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft <= 1) {
        timer.cancel();
        _handleTimeExpired();
      } else {
        _timeLeft--;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void _handleTimeExpired() {
    if (state.gameOver) return;
    updateState(state.copyWith(gameOver: true));
    onTimeExpired();
  }

  @override
  Future<void> onColorTap(int index) async {
    if (state.gameOver || state.showingSequence) return;

    updateState(state.copyWith(tappedIndex: index));
    await playSound(index);
    await Future.delayed(const Duration(milliseconds: 160));
    updateState(state.copyWith(tappedIndex: null));

    final newPlayerMoves = List<int>.from(state.playerMoves)..add(index);
    updateState(state.copyWith(playerMoves: newPlayerMoves));

    if (newPlayerMoves.last != state.sequence[newPlayerMoves.length - 1]) {
      updateState(state.copyWith(gameOver: true));
      onIncorrectSequence();
      return;
    }

    if (newPlayerMoves.length == state.sequence.length) {
      _roundTimer?.cancel();

      final elapsed =
          DateTime.now().difference(_roundStartTime!).inMilliseconds / 1000.0;
      final efficiency = (_roundDuration - elapsed) / _roundDuration;
      final gained = 1 + (efficiency * 1);

      _score += gained;
      notifyListeners();
      nextRound();
    }
  }

  @override
  void dispose() {
    _roundTimer?.cancel();
    super.dispose();
  }

  void onTimeExpired() {
    updateState(state.copyWith(gameOver: true, gameOverReason: "Time's up!"));
    notifyListeners();
  }

  void onIncorrectSequence() {
    updateState(
      state.copyWith(gameOver: true, gameOverReason: "Incorrect sequence."),
    );
    notifyListeners();
  }
}
