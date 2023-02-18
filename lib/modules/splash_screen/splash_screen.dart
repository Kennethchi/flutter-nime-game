import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nimle/modules/splash_screen/splash_screen_bloc.dart';
import 'package:nimle/res/app_routes.dart';
import 'package:nimle/res/constants/layout_constants.dart';
import 'package:nimle/res/constants/app_constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {

  SplashScreenBloc _bloc = SplashScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: [

            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nimle",
                            style: TextStyle(
                              fontSize: LayoutConstants.title_fontsize(context),
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(width: 20.0,),
                          Animator(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeOutBack,
                            builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                              return Container(
                                width: LayoutConstants.logo_size(context),
                                height: LayoutConstants.logo_size(context),
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget> [
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget> [
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget> [
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                          Icon(Icons.circle, color: Colors.white, size: 20.0 * animatorState.value,),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                      SizedBox(height: 20.0,),

                      Text("(A Game of Strategy)", style: TextStyle(
                        color: Colors.white,
                        fontSize: LayoutConstants.subtitle_fontsize(context)
                      ),)
                    ],
                  ),

                  GestureDetector(
                    onTap: (){

                      Navigator.of(context).popAndPushNamed(AppRoutes.game_stage);
                    },
                    child: Animator(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOutBack,
                        builder: (BuildContext context, AnimatorState<dynamic> animatorStateScaleButton, Widget? child) {
                          return Transform.scale(
                            scale: animatorStateScaleButton.value,
                            child: Animator(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 1000),
                                cycles: double.maxFinite.toInt(),
                                curve: Curves.linear,
                                builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                  return SizedBox(
                                    width: LayoutConstants.button_size(context)!.width,
                                    height: LayoutConstants.button_size(context)!.height,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 5)
                                      ,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 5.0 * animatorState.value, // soften the shadow
                                              spreadRadius: 5.0 * animatorState.value,
                                            )
                                          ]
                                      ),
                                      child: Center(
                                        child: Text("START", style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: LayoutConstants.subtitle_fontsize(context),
                                        ),),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                    ),
                  ),
                  
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Version: ${App_Constants.game_version}",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
