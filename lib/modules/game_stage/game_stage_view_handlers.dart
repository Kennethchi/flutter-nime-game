import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nimle/modules/game_stage/game_stage_bloc_provider.dart';
import 'package:nimle/res/models/player_stats_model.dart';

import '../../res/constants/constants.dart';
import 'game_stage_bloc.dart';


class GameStageViewHandlers{

  static Future<void> showHowToPlay({required BuildContext context})async{

    await showDialog(
        context: context,
        builder: (BuildContext context){
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
              child: Animator(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 750),
                curve: Curves.easeInOutBack,
                builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                  return Transform.scale(
                    scale: animatorState.value,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 1000.0? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                        icon: Icon(Icons.clear, color: Colors.grey),
                                    ),
                                  ],
                                ),

                                Text("How to PLAY", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor
                                ),),
                                SizedBox(height: 20.0,),

                                Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(backgroundColor: Colors.grey, radius: 4.0,),
                                      title: Text("Nimle is a game where you pick marbles by selecting them and "
                                          "the LAST player to pick, LOOSES the game", style: TextStyle(fontSize: 12.0),),
                                      subtitle: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor,
                                                    borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text("Select"),
                                                  Icon(Icons.arrow_right_alt, size: 30.0,),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                    border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      dense: false,
                                    ),

                                    ListTile(
                                      leading: CircleAvatar(backgroundColor: Colors.grey, radius: 4.0,),
                                      title: Text("You can pick any number of marbles from ONLY ONE row per turn",
                                          style: TextStyle(fontSize: 12.0)
                                      ),
                                      subtitle: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      dense: false,
                                    ),

                                    ListTile(
                                      leading: CircleAvatar(backgroundColor: Colors.grey, radius: 4.0,),
                                      title: Text("You CANNOT select marbles from more than ONE row per turn",
                                          style: TextStyle(fontSize: 12.0)
                                      ),
                                      subtitle: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.0),
                                                              border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.0),
                                                              border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.0),
                                                              border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.0),
                                                              border: Border.all(color: Theme.of(context).primaryColor, width: 3.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius: BorderRadius.circular(30.0)
                                                          ),
                                                        ),
                                                      ),


                                                    ],
                                                  ),


                                                ],
                                              ),

                                              Icon(Icons.clear, color: Colors.redAccent, size: 30.0,)
                                            ],
                                          ),


                                        ),
                                      ),
                                      dense: false,
                                    ),

                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          );
    });
  }



  static void showPlayerBeginChoice({required BuildContext context, @required GameStageBloc? gameStageBloc}){


    showDialog(
        barrierDismissible: false,
        context: context, builder: (BuildContext context){
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Center(
          child: Animator(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 750),
            curve: Curves.easeInOutBack,
            builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
              return Transform.scale(
                scale: animatorState.value,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 1000.0? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text("Please Select a Turn to Go"),
                            SizedBox(height: 40.0,),

                            TextButton(
                                onPressed: (){
                                  if (gameStageBloc != null){
                                    gameStageBloc.playerTurnBehaviorSubject.add(Player_Type.CURRENT_PLAYER);
                                    Navigator.of(context).pop();
                                  }

                                },
                                child: const Text("START FIRST", style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),

                            TextButton(onPressed: (){

                              if (gameStageBloc != null){
                                gameStageBloc.playerTurnBehaviorSubject.add(Player_Type.AI);
                                Navigator.of(context).pop();
                              }
                            },
                                child: const Text("START SECOND", style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      );
    });

  }



  static Future<void> showDifficultyLevel({required BuildContext context, GameStageBloc? gameStageBloc})async{


    await showDialog(
        context: context,
        builder: (BuildContext context){

          return Center(
            child: Animator(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 750),
                curve: Curves.easeInOutBack,
              builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                return Transform.scale(
                  scale: animatorState.value,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width < 1000.0? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.5,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Choose Difficulty Level"),
                              SizedBox(height: 20.0,),

                              TextButton(
                                onPressed: (){

                                  if (gameStageBloc != null){

                                    gameStageBloc.storeDifficultyLevel(ai_difficulty: AiDifficulty.easy).then((value){
                                      gameStageBloc.getDifficultyLevel().then((value){
                                        if (value != null){
                                          gameStageBloc.aiDifficultyBehaviorSubject.add(value);

                                          Phoenix.rebirth(context);
                                        }
                                      });
                                    });
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("EASY", style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(width: 20.0,),

                                      StreamBuilder<AI_Difficulty>(
                                        stream: gameStageBloc!.aiDifficultyBehaviorSubject.stream,
                                        builder: (context, snapshot) {

                                          if (snapshot.hasData && snapshot.data == AI_Difficulty.EASY){
                                            return Icon(Icons.check_circle, color: Theme.of(context).primaryColor,);
                                          }
                                          return Container();
                                        }
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.0,),

                              TextButton(
                                onPressed: (){

                                  if (gameStageBloc != null){

                                    gameStageBloc.storeDifficultyLevel(ai_difficulty: AiDifficulty.normal).then((value){
                                      gameStageBloc.getDifficultyLevel().then((value){
                                        if (value != null){
                                          gameStageBloc.aiDifficultyBehaviorSubject.add(value);

                                          Phoenix.rebirth(context);
                                        }
                                      });
                                    });
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("NORMAL", style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(width: 20.0,),

                                      StreamBuilder<AI_Difficulty>(
                                          stream: gameStageBloc.aiDifficultyBehaviorSubject.stream,
                                          builder: (context, snapshot) {

                                            if (snapshot.hasData && snapshot.data == AI_Difficulty.NORMAL){
                                              return Icon(Icons.check_circle, color: Theme.of(context).primaryColor,);
                                            }
                                            return Container();
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.0,),

                              TextButton(
                                onPressed: (){

                                  if (gameStageBloc != null){

                                    gameStageBloc.storeDifficultyLevel(ai_difficulty: AiDifficulty.hard).then((value){
                                      gameStageBloc.getDifficultyLevel().then((value){
                                        if (value != null){
                                          gameStageBloc.aiDifficultyBehaviorSubject.add(value);

                                          Phoenix.rebirth(context);
                                        }
                                      });
                                    });
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("HARD", style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(width: 20.0,),

                                      StreamBuilder<AI_Difficulty>(
                                          stream: gameStageBloc.aiDifficultyBehaviorSubject.stream,
                                          builder: (context, snapshot) {

                                            if (snapshot.hasData && snapshot.data == AI_Difficulty.HARD){
                                              return Icon(Icons.check_circle, color: Theme.of(context).primaryColor,);
                                            }
                                            return Container();
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.0,),

                              TextButton(
                                onPressed: (){

                                  if (gameStageBloc != null){

                                    gameStageBloc.storeDifficultyLevel(ai_difficulty: AiDifficulty.insane).then((value){
                                      gameStageBloc.getDifficultyLevel().then((value){
                                        if (value != null){
                                          gameStageBloc.aiDifficultyBehaviorSubject.add(value);

                                          Phoenix.rebirth(context);
                                        }
                                      });
                                    });
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("INSANE", style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(width: 20.0,),

                                      StreamBuilder<AI_Difficulty>(
                                          stream: gameStageBloc.aiDifficultyBehaviorSubject.stream,
                                          builder: (context, snapshot) {

                                            if (snapshot.hasData && snapshot.data == AI_Difficulty.INSANE){
                                              return Icon(Icons.check_circle, color: Theme.of(context).primaryColor,);
                                            }
                                            return Container();
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        }
    );

  }


  static Future<void> showPlayerStats({required BuildContext context, required GameStageBloc? gameStageBloc})async{

    if (gameStageBloc != null){


      await showDialog(
          context: context,
          builder: (BuildContext context){

            return Center(
              child: Animator(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 750),
                  curve: Curves.easeInOutBack,
                  builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                    return Transform.scale(
                      scale: animatorState.value,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width < 1000.0? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * 0.5,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Your STATS", style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 40.0,),

                                  StreamBuilder<PlayerStatsModel>(
                                      stream: gameStageBloc.playerStatsModelBehaviorSubject.stream,
                                      builder: (context, snapshot) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 30,
                                                  child: Center(
                                                    child: Text("EASY LEVEL : ",
                                                      style: TextStyle(
                                                        color: Theme.of(context).primaryColor,
                                                        fontWeight: FontWeight.w900
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Played:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_matches_vs_easy.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Won:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_wins_vs_easy.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.greenAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Lossed:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_losses_vs_easy.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.orangeAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Theme.of(context).primaryColor,
                                              height: 20.0,
                                            ),

                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 30,
                                                  child: Center(
                                                    child: Text("NORMAL LEVEL : ",
                                                      style: TextStyle(
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.w900
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Played:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_matches_vs_normal.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Won:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_wins_vs_normal.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.greenAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Lossed:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_losses_vs_normal.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.orangeAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Theme.of(context).primaryColor,
                                              height: 20.0,
                                            ),

                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 30,
                                                  child: Center(
                                                    child: Text("HARD LEVEL : ",
                                                      style: TextStyle(
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.w900
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Played:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_matches_vs_hard.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Won:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_wins_vs_hard.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.greenAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Lossed:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_losses_vs_hard.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.orangeAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Theme.of(context).primaryColor,
                                              height: 20.0,
                                            ),

                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 30,
                                                  child: Center(
                                                    child: Text("INSANE LEVEL : ",
                                                      style: TextStyle(
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.w900
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Played:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_matches_vs_insane.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Won:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_wins_vs_insane.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.greenAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.0,),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("Matches Lossed:"),
                                                          SizedBox(width: 10.0,),
                                                          Text(
                                                            snapshot.hasData? snapshot.data!.total_losses_vs_insane.toString(): "N/A",
                                                            style: TextStyle(
                                                                color: Colors.orangeAccent,
                                                                fontWeight: FontWeight.bold,
                                                              fontSize: 18.0
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20.0,),

                                          ],
                                        );
                                      }
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            );
          }
      );
    }


  }
}




