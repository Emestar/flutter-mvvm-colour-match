import 'package:flutter/material.dart';
import 'package:color_match/models/constants.dart';
import 'package:color_match/models/mode_option.dart';
import 'package:color_match/views/widgets/gradient_background.dart';
import 'package:color_match/views/widgets/mode_button.dart';
import 'package:color_match/views/games/classic.dart';
import 'package:color_match/views/games/hard.dart';
import 'package:color_match/views/games/time.dart';
import 'package:color_match/views/games/infinite.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Color Match',
            style: TextStyle(color: ktextcolor, fontSize: 48),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kgradientfour),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: kgradientbackground),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final buttonSize = constraints.maxWidth > 700 ? 220.0 : 160.0;
              final options = [
                ModeOption(
                  label: 'Classic Mode',
                  color: konecolor,
                  icon: Icons.tag_faces_outlined,
                  builder: () => const GameModeClassic(),
                ),
                ModeOption(
                  label: 'Hard Mode',
                  color: ktwocolor,
                  icon: Icons.add_reaction_outlined,
                  builder: () => const GameModeHard(),
                ),
                ModeOption(
                  label: 'Time Mode',
                  color: kthreecolor,
                  icon: Icons.access_alarm_outlined,
                  builder: () => const GameModeTime(),
                ),
                ModeOption(
                  label: 'Infinity Mode',
                  color: kfourcolor,
                  icon: Icons.add_alarm_outlined,
                  builder: () => const GameModeInfinity(),
                ),
              ];

              return Center(
                child: Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: options
                      .map(
                        (option) =>
                            ModeButton(option: option, size: buttonSize),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

