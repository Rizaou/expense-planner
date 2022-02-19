import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_providder_program_settings.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:gelir_gider/screens/introduction_screen.dart.dart';

const double global_elevation_value = 4;
const double global_horizontal_padding = 10;
const global_card_height_px = 80.0;
Color primaryColor = Colors.green.shade900;
Color secondaryColor = Colors.deepOrangeAccent.shade700;
Color cardColor = Colors.blueGrey.shade900;
const double global_card_corner_big = 12;
const double global_card_corner_low = 8;

Future<Widget> get getFirstScreen async =>
    await DBHelperProgramSettings.isFirstTime
        ? IntroductionScreen()
        : HomeScreen();
