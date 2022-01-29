import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_providder_program_settings.dart';
import 'package:gelir_gider/screens/home_screen.dart';
import 'package:gelir_gider/screens/introduction_screen.dart.dart';

const double global_elevation_value = 4;
const double global_horizontal_padding = 10;
const global_card_height_px = 60.0;
Color scaffoldBGColor = Colors.green.shade900;

Future<Widget> get getFirstScreen async =>
    await DBHelperProgramSettings.isFirstTime
        ? IntroductionScreen()
        : HomeScreen();
