import 'dart:async';
import 'dart:html';
import 'dart:math';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nimle/extra_widgets/confetti_particles.dart';
import 'package:nimle/extra_widgets/confetti_celebration.dart';
import 'package:nimle/modules/authentication/authentication.dart';
import 'package:nimle/modules/game_stage/game_stage.dart';
import 'package:nimle/modules/splash_screen/splash_screen.dart';
import 'package:nimle/res/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/app/app.dart';
//import 'package:firebase_core/firebase_core.dart';


void main(){

  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(Phoenix(
      child: const App()
  ));
}


