import 'package:color_match/models/game_palette.dart';

class GameState {
  final List<int> sequence;
  final List<int> playerMoves;
  final int score;
  final bool gameOver;
  final String? gameOverReason;
  final bool showingSequence;
  final int? highlightedIndex;
  final int? tappedIndex;
  final GamePalette? palette;

  const GameState({
    this.sequence = const [],
    this.playerMoves = const [],
    this.score = 0,
    this.gameOver = false,
    this.gameOverReason,
    this.showingSequence = false,
    this.highlightedIndex,
    this.tappedIndex,
    this.palette,
  });

  GameState copyWith({
    List<int>? sequence,
    List<int>? playerMoves,
    int? score,
    bool? gameOver,
    String? gameOverReason,
    bool? showingSequence,
    Object? highlightedIndex = _keepValue,
    Object? tappedIndex = _keepValue,
    GamePalette? palette,
  }) {
    return GameState(
      sequence: sequence ?? this.sequence,
      playerMoves: playerMoves ?? this.playerMoves,
      score: score ?? this.score,
      gameOver: gameOver ?? this.gameOver,
      gameOverReason: gameOverReason ?? this.gameOverReason,
      showingSequence: showingSequence ?? this.showingSequence,
      highlightedIndex: highlightedIndex == _keepValue
          ? this.highlightedIndex
          : highlightedIndex as int?,
      tappedIndex: tappedIndex == _keepValue
          ? this.tappedIndex
          : tappedIndex as int?,
      palette: palette ?? this.palette,
    );
  }
}

// Helper object to distinguish between null and undefined
const Object _keepValue = Object();
