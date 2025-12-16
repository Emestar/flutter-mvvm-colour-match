import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:color_match/models/game_palette.dart';
import 'package:color_match/models/game_state.dart';
import 'package:color_match/models/constants.dart';
import 'package:flutter/material.dart';

abstract class BaseGameViewModel extends ChangeNotifier {
  GameState _state;
  final Random _random = Random();
  final List<AudioPlayer> _players = List.generate(
    soundFiles.length,
    (_) => AudioPlayer(),
  );

  BaseGameViewModel(this._state) {
    _initializePlayers();
  }

  void _initializePlayers() {
    for (int i = 0; i < soundFiles.length; i++) {
      _players[i].setSource(AssetSource(soundFiles[i]));
    }
  }

  GameState get state => _state;

  GamePalette get palette => _state.palette!;

  List<Color> get activeColors => palette.config.colors;

  void updateState(GameState newState) {
    _state = newState;
    notifyListeners();
  }

  void startGame();
  void nextRound();
  Future<void> playSequence();
  Future<void> onColorTap(int index);

  @override
  void dispose() {
    for (var player in _players) {
      player.dispose();
    }
    super.dispose();
  }

  Future<void> playSound(int index) async {
    await player.play(AssetSource(soundFiles[index]));
  }

  int getRandomColorIndex() {
    return _random.nextInt(activeColors.length);
  }
}
