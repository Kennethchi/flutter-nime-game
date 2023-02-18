

import 'package:flutter/material.dart';
import 'package:nimle/modules/authentication/authentication.dart';
import 'package:nimle/modules/game_stage/game_stage.dart';
import 'package:nimle/modules/splash_screen/splash_screen.dart';

class AppRoutes{

  static const String splashScreen = "/splash_screen";
  static const String authentication = "/authentication";
  static const String game_stage = "/game_stage";

  static Map<String, WidgetBuilder> get getAppRoutes => {
    splashScreen: (BuildContext context) => SplashScreen(),
    authentication: (BuildContext context) => Authentication(),
    game_stage: (BuildContext context) => GameStage()
  };

}