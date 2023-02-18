import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nimle/extra_widgets/confetti_celebration.dart';
import 'package:nimle/modules/game_stage/game_stage_bloc.dart';
import 'package:nimle/modules/game_stage/game_stage_bloc_provider.dart';
import 'package:nimle/modules/game_stage/game_stage_view_handlers.dart';
import 'package:nimle/modules/game_stage/game_stage_view_widgets.dart';
import 'package:nimle/res/constants/constants.dart';
import 'package:nimle/res/constants/layout_constants.dart';
import 'package:nimle/res/models/game_boad_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/constants/app_constants.dart';


class GameStage extends StatefulWidget {
  const GameStage({Key? key}) : super(key: key);

  @override
  _GameStageState createState() => _GameStageState();
}


class _GameStageState extends State<GameStage> with AutomaticKeepAliveClientMixin<GameStage>, AfterLayoutMixin<GameStage>{

  GameStageBloc _bloc = GameStageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<bool> seenTutorial()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = "seen_tutorial";

    if (prefs.getBool(key) != null && prefs.getBool(key)!){
      return true;
    }
    else{
      await prefs.setBool(key, true);
      return false;
    }
  }



  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    seenTutorial().then((seenTutotial){
      if (seenTutotial != null && seenTutotial){
        GameStageViewHandlers.showPlayerBeginChoice(context: context, gameStageBloc: _bloc);
      }
      else{

        GameStageViewHandlers.showHowToPlay(context: context).then((value){

          GameStageViewHandlers.showPlayerBeginChoice(context: context, gameStageBloc: _bloc);
        });
      }

    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    return GameStageBlocProvider(
      bloc: _bloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [

            StreamBuilder<Player_Type>(
              stream: _bloc.playerTurnBehaviorSubject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Animator(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      cycles: double.maxFinite.toInt(),
                      curve: Curves.linear,
                      builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: snapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent,
                                    blurRadius: 20.0 * animatorState.value, // soften the shadow
                                    spreadRadius: 20.0 * animatorState.value, //extend the shadow
                                  )
                                ]
                            )
                        );
                      },
                    ),
                  );
                }
                else{
                  return Container();
                }

              }
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          PopupMenuButton(
                              icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,),
                              //initialValue: MenuOptions.HOW_TO_PLAY,
                              onSelected: (value){
                                if (value == MenuOptions.HOW_TO_PLAY){
                                  GameStageViewHandlers.showHowToPlay(context: context);
                                }
                                else if (value == MenuOptions.DIFFICULTY_LEVEL){
                                  GameStageViewHandlers.showDifficultyLevel(context: context, gameStageBloc: _bloc);
                                }
                                else if (value == MenuOptions.PLAYER_STATS){
                                  GameStageViewHandlers.showPlayerStats(context: context, gameStageBloc: _bloc);
                                }
                                else if(value == MenuOptions.SHARE){
                                  Share.share(App_Constants.app_main_url);
                                }
                              },
                              itemBuilder: (BuildContext context){
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                value: MenuOptions.HOW_TO_PLAY,
                                child: Row(
                                  children: [
                                    Icon(Icons.info, color: Theme.of(context).primaryColor, size: 20.0,),
                                    SizedBox(width: 10.0,),
                                    Text("How To Play", style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14.0
                                    ),),

                                  ],
                                ),
                              ),

                              PopupMenuItem(
                                value: MenuOptions.DIFFICULTY_LEVEL,
                                child: Row(
                                  children: [
                                    Icon(Icons.sports, color: Theme.of(context).primaryColor, size: 20.0,),
                                    SizedBox(width: 10.0,),
                                    Text("Difficulty Level", style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.0
                                    ),),

                                  ],
                                ),
                              ),

                              PopupMenuItem(
                                value: MenuOptions.PLAYER_STATS,
                                child: Row(
                                  children: [
                                    Icon(Icons.stacked_bar_chart, color: Theme.of(context).primaryColor, size: 20.0,),
                                    SizedBox(width: 10.0,),
                                    Text("Your Stats", style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.0
                                    ),),

                                  ],
                                ),
                              ),

                              PopupMenuItem(
                                value: MenuOptions.SHARE,
                                child: Row(
                                  children: [
                                    Icon(Icons.share, color: Theme.of(context).primaryColor, size: 20.0,),
                                    SizedBox(width: 10.0,),
                                    Text("Share", style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.0
                                    ),),

                                  ],
                                ),
                              )
                            ];
                          }, ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0, top: 20.0),
                      child: Text("Nimle", style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: LayoutConstants.title_fontsize(context)
                      ),),
                    ),


                    Flexible(
                      child: Center(
                        child: StreamBuilder<Player_Type>(
                          stream: _bloc.playerWinnerBehaviorSubject.stream,
                          builder: (context, snapshot) {

                            if (snapshot.hasData && snapshot.data != Player_Type.NONE){

                              if (snapshot.data == Player_Type.CURRENT_PLAYER){
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Animator(
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          duration: const Duration(milliseconds: 1000),
                                          cycles: double.maxFinite.toInt(),
                                          curve: Curves.easeOut,
                                          builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                            return Opacity(
                                              opacity: animatorState.value * 1.0,
                                              child: Text("You WON",
                                                style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: LayoutConstants.subtitle2_fontsize(context),
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 50.0,
                                        ),

                                        Animator(
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          duration: const Duration(milliseconds: 1000),
                                          curve: Curves.easeOutBack,
                                          builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                            return Transform.scale(
                                              scale: animatorState.value,
                                              child: InkWell(
                                                  onTap: (){

                                                    /*
                                                _bloc.playerWinnerBehaviorSubject.add(Player_Type.NONE);
                                                _bloc.resetGame();
                                                GameStageViewHandlers.showPlayerBeginChoice(context: context);
                                                 */

                                                    Phoenix.rebirth(context);
                                                  },
                                                  child: SizedBox(
                                                    width: LayoutConstants.button_size(context)!.width,
                                                    height: LayoutConstants.button_size(context)!.height,
                                                    child: Container(
                                                        padding: EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(context).primaryColor,
                                                            borderRadius: BorderRadius.circular(30.0)
                                                        ),
                                                        child: Center(
                                                          child: Text("Rematch",
                                                            style: TextStyle(color: Colors.white,
                                                                fontWeight: FontWeight.w900,
                                                                fontSize: LayoutConstants.subtitle_fontsize(context)
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  )
                                              ),
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                    ConfettiCelebration()
                                  ],
                                );
                              }
                              else{

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Animator(
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      duration: const Duration(milliseconds: 1000),
                                      cycles: 1000000000,
                                      curve: Curves.easeOut,
                                      builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                        return Opacity(
                                          opacity: animatorState.value * 1.0,
                                          child: Text("YOU LOOSE",
                                            style: TextStyle(
                                                color: Colors.orangeAccent,
                                                fontSize: LayoutConstants.subtitle2_fontsize(context)
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                    ),

                                    Animator(
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        duration: const Duration(milliseconds: 1000),
                                        curve: Curves.easeOutBack,
                                        builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                          return Transform.scale(
                                            scale: animatorState.value,
                                            child: InkWell(
                                                onTap: (){

                                                  /*
                                                _bloc.playerWinnerBehaviorSubject.add(Player_Type.NONE);
                                                _bloc.resetGame();
                                                GameStageViewHandlers.showPlayerBeginChoice(context: context);
                                                 */

                                                  Phoenix.rebirth(context);
                                                },
                                                child: SizedBox(
                                                  width: LayoutConstants.button_size(context)!.width,
                                                  height: LayoutConstants.button_size(context)!.height,
                                                  child: Container(
                                                      padding: EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(context).primaryColor,
                                                          borderRadius: BorderRadius.circular(30.0)
                                                      ),
                                                      child: Center(
                                                        child: Text("Rematch",
                                                          style: TextStyle(color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: LayoutConstants.subtitle_fontsize(context)
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                )
                                            ),
                                          );
                                        }
                                    )
                                  ],
                                );
                              }

                            }
                            else{
                              return Container(
                                child: StreamBuilder<GameBoardModel>(
                                    stream: _bloc.gameBoardModelBehaviorSubject.stream,
                                    initialData: GameBoardModel(),
                                    builder: (context, snapshot) {

                                      switch(snapshot.connectionState){

                                        case ConnectionState.none: case ConnectionState.waiting:
                                          return Container();
                                        case ConnectionState.active: case ConnectionState.done:
                                        if (snapshot.data != null){
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GameBoardWidget(gameBoardModel: snapshot.requireData),
                                              SizedBox(height: 20.0,),

                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [

                                                        Text("Marbles Left",
                                                          style: TextStyle(
                                                              color: Theme.of(context).backgroundColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: LayoutConstants.subtitle_fontsize(context)
                                                          ),
                                                        ),
                                                        SizedBox(height: 8.0,),

                                                        StreamBuilder<Player_Type>(
                                                          stream: _bloc.playerTurnBehaviorSubject.stream,
                                                          builder: (context, playerTurnSnapshot) {
                                                            return Container(
                                                              child: StreamBuilder<int>(
                                                                  stream: _bloc.totalNodesLeftBehaviorSubject.stream,
                                                                  builder: (context, totalNodesLeftSnappshot) {
                                                                    return Text("${totalNodesLeftSnappshot.hasData? totalNodesLeftSnappshot.data: Game_Constants.number_of_nodes}",
                                                                      style: TextStyle(
                                                                          color: playerTurnSnapshot.hasData
                                                                                  ? (playerTurnSnapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent)
                                                                              : Theme.of(context).primaryColor,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: LayoutConstants.subtitle2_fontsize(context)
                                                                      ),);
                                                                  }
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                      ],
                                                    ),

                                                    Column(
                                                      children: [
                                                        Text("Difficulty Level",
                                                          style: TextStyle(
                                                              color: Theme.of(context).backgroundColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: LayoutConstants.subtitle_fontsize(context)
                                                          ),
                                                        ),
                                                        SizedBox(height: 8.0,),

                                                        StreamBuilder<Player_Type>(
                                                            stream: _bloc.playerTurnBehaviorSubject.stream,
                                                            builder: (context, playerTurnSnapshot) {
                                                              return Container(
                                                                child: StreamBuilder<AI_Difficulty>(
                                                                    stream: _bloc.aiDifficultyBehaviorSubject.stream,
                                                                    builder: (context, snapshot) {

                                                                      String ai_level_string = "";
                                                                      if (snapshot.hasData && snapshot.data != null){
                                                                        switch(snapshot.data){

                                                                          case AI_Difficulty.EASY:
                                                                            ai_level_string = "EASY";
                                                                            break;
                                                                          case AI_Difficulty.NORMAL:
                                                                            ai_level_string = "NORMAL";
                                                                            break;
                                                                          case AI_Difficulty.HARD:
                                                                            ai_level_string = "HARD";
                                                                            break;
                                                                          case AI_Difficulty.INSANE:
                                                                            ai_level_string = "INSANE";
                                                                            break;
                                                                          default:
                                                                            break;
                                                                        }
                                                                      }

                                                                      return Text("${snapshot.hasData? ai_level_string: "N/A"}",
                                                                        style: TextStyle(
                                                                            color: playerTurnSnapshot.hasData
                                                                                ? (playerTurnSnapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent)
                                                                                : Theme.of(context).primaryColor,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: LayoutConstants.subtitle2_fontsize(context)
                                                                        ),);
                                                                    }
                                                                ),
                                                              );
                                                            }
                                                        ),

                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        else{
                                          return Container();
                                        }
                                      }
                                    }
                                ),
                              );
                            }

                          }
                        ),
                      ),
                    ),


                    StreamBuilder<Player_Type>(
                      stream: _bloc.playerWinnerBehaviorSubject.stream,
                      builder: (context, playerWinnerSnapshot) {

                        if (playerWinnerSnapshot.hasData && playerWinnerSnapshot.data != null){
                          return Container();
                        }

                        return Container(
                          child: StreamBuilder<Player_Type>(
                            stream: _bloc.playerTurnBehaviorSubject.stream,
                            builder: (context, playerTurnSnapshot) {

                              if (playerTurnSnapshot.hasData && playerTurnSnapshot.data == Player_Type.CURRENT_PLAYER){
                                return Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Animator(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOutBack,
                                    builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                      return Transform.scale(
                                        scale: animatorState.value,
                                        child: InkWell(
                                            onTap: (){


                                              _bloc.updateTotalNodesLeft();
                                              if (_bloc.totalNodesLeft == _bloc.previousTotalNodesLeft){
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text("You have not Selected", style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    ],
                                                  ),
                                                ));
                                              }
                                              else if (_bloc.numRowsSelected.length > 1){

                                                _bloc.gameBoardModelBehaviorSubject.add(_bloc.gameBoardModel);

                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text("You can ONLY select from One Row", style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    ],
                                                  ),
                                                ));
                                              }
                                              else{
                                                _bloc.clearPlayerTurnState();
                                                _bloc.disableSelectedNodes();
                                                _bloc.updateTotalNodesLeft();
                                                _bloc.previousTotalNodesLeft = _bloc.totalNodesLeft;
                                                _bloc.playerTurnBehaviorSubject.add(Player_Type.AI);
                                                _bloc.gameBoardModelBehaviorSubject.add(_bloc.gameBoardModel);

                                                _bloc.previousTotalNodesLeft = _bloc.totalNodesLeft;
                                                if (_bloc.totalNodesLeft == 0){
                                                  _bloc.playerWinnerBehaviorSubject.add(Player_Type.AI);
                                                }
                                              }

                                            },
                                            child: SizedBox(
                                              width: LayoutConstants.button_size(context)!.width,
                                              height: LayoutConstants.button_size(context)!.height,
                                              child: Container(
                                                //padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(30.0)
                                                ),
                                                child: Center(
                                                  child: Text("Finish Turn",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: LayoutConstants.subtitle_fontsize(context)
                                                    ),
                                                  ),
                                                )
                                              ),
                                            )
                                        ),
                                      );
                                    }
                                  ),
                                );
                              }
                              else{
                                return Container();
                              }

                            }
                          ),
                        );
                      }
                    ),

                    StreamBuilder<Player_Type>(
                      stream: _bloc.playerWinnerBehaviorSubject.stream,
                      builder: (context, playerWinnerSnapshot) {

                        if (playerWinnerSnapshot.hasData && playerWinnerSnapshot.data != null){
                          return playerWinnerSnapshot.data == Player_Type.AI? Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Animator(
                              tween: Tween(begin: 0.2, end: 1.0),
                              duration: const Duration(milliseconds: 1000),
                              cycles: double.maxFinite.toInt(),
                              curve: Curves.easeOut,
                              builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                return Opacity(
                                  opacity: animatorState.value * 1.0,
                                  child: Text("GAME OVER",
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: LayoutConstants.subtitle2_fontsize(context)
                                    ),),
                                );
                              },
                            ),
                          ): Container();
                        }
                        else{

                          return Container(
                            child: StreamBuilder<Player_Type>(
                                stream: _bloc.playerTurnBehaviorSubject.stream,
                                builder: (context, playerTurnSnapshot) {

                                  if (playerTurnSnapshot.hasData){

                                    return Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Animator(
                                        tween: Tween(begin: 0.2, end: 1.0),
                                        duration: const Duration(milliseconds: 1000),
                                        cycles: double.maxFinite.toInt(),
                                        curve: Curves.easeOut,
                                        builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                                          return Opacity(
                                            opacity: animatorState.value * 1.0,
                                            child: Text(playerTurnSnapshot.data == Player_Type.CURRENT_PLAYER? "Your Turn" : "Opponent Turn",
                                              style: TextStyle(
                                                  color: playerTurnSnapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent,
                                                  fontSize: LayoutConstants.subtitle2_fontsize(context)
                                              ),),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  else{
                                    return Container();
                                  }


                                }
                            ),
                          );
                        }

                      }
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Vers: ${App_Constants.game_version}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        )
      ),
    );
  }


}


