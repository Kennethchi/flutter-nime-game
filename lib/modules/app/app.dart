import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nimle/extra_widgets/confetti_celebration.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/app_routes.dart';
import '../game_stage/game_stage.dart';
import '../splash_screen/splash_screen.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with AutomaticKeepAliveClientMixin<App>{

  Future<bool> firstVisited()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = "first_visited";

    if (prefs.getBool(key) != null && prefs.getBool(key)!){
      return true;
    }
    else{
      await prefs.setBool(key, true);
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Nimle',
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getAppRoutes,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple
      ),

      home: FutureBuilder<bool>(
          future: firstVisited(),
          builder: (context, snapshot) {

            //print(MediaQuery.of(context).size.height);


            return SplashScreen();

            switch(snapshot.connectionState){

              case ConnectionState.none: case ConnectionState.waiting:
                return Container();
              case ConnectionState.active: case ConnectionState.done:
                if (snapshot.hasData && snapshot.data!){
                  return GameStage();
                }
                else{
                  return SplashScreen();
                }

            }

          }
      ),
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
