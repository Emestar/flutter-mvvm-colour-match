import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

const Color kbackgroundcolor = Color.fromARGB(255, 32, 40, 51);
const Color ktextcolor = Color.fromARGB(255, 244, 247, 248);

const LinearGradient kgradientfour = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: colorsclassic,
);
const LinearGradient kgradientbackground = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kbackgroundcolor, Color.fromARGB(255, 6, 10, 15)],
);

const Color konecolor = Color.fromARGB(255, 204, 11, 11);
const Color ktwocolor = Color.fromARGB(255, 226, 195, 20);
const Color kthreecolor = Color.fromARGB(255, 19, 112, 219);
const Color kfourcolor = Color.fromARGB(255, 26, 175, 21);
const Color kfivecolor = Color.fromARGB(255, 235, 140, 15);
const Color ksixcolor = Color.fromARGB(255, 153, 18, 216);

const List<Color> colorsclassic = [
  konecolor,
  ktwocolor,
  kthreecolor,
  kfourcolor,
];
const List<Color> colorshard = [...colorsclassic, kfivecolor, ksixcolor];

const List<IconData> icons = [
  Icons.favorite_border_outlined,
  Icons.star_border_outlined,
  Icons.water_drop_outlined,
  Icons.public_outlined,
  Icons.wb_sunny_outlined,
  Icons.nightlight_outlined,
  Icons.tag_faces_outlined,
  Icons.color_lens_outlined,
];

final player = AudioPlayer();

const List<String> soundFiles = [
  'sounds/do.mp3',
  'sounds/re.mp3',
  'sounds/mi.mp3',
  'sounds/fa.mp3',
  'sounds/sol.mp3',
  'sounds/la.mp3',
  'sounds/si.mp3',
];

