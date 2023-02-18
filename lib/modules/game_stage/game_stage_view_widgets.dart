import 'dart:html';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nimle/modules/game_stage/game_stage_bloc_provider.dart';
import 'package:nimle/res/constants/constants.dart';
import 'package:nimle/res/constants/layout_constants.dart';
import 'package:nimle/res/models/game_boad_model.dart';
import 'package:nimle/res/models/node_model.dart';

import 'game_stage_bloc.dart';


class GameBoardWidget extends StatelessWidget {

  GameBoardModel gameBoardModel;

  GameBoardWidget({Key? key, required this.gameBoardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GameStageBloc _bloc = GameStageBlocProvider.of(context)!.bloc;

    List<Widget> widgetsRowList_One = List.filled(3, Container(), growable: true);
    List<Widget> widgetsRowList_Two = List.filled(3, Container(), growable: true);
    List<Widget> widgetsRowList_Three = List.filled(3, Container(), growable: true);

    List<Widget> widgetsColumnList = List.filled(0, Container(), growable: true);


    for (int rowIndex = 0; rowIndex < gameBoardModel.initial_state.length; ++rowIndex){

      List<NodeModel> tempNodeModelRowList = gameBoardModel.initial_state[rowIndex];

      for (int columnIndex = 0; columnIndex < tempNodeModelRowList.length; ++columnIndex){
        NodeModel currentNodeModel = gameBoardModel.initial_state[rowIndex][columnIndex];

        Widget widget = Flexible(
          child: currentNodeModel.is_enabled? StreamBuilder<Player_Type>(
            stream: _bloc.playerTurnBehaviorSubject.stream,
            builder: (context, playerTurnSnapshot) {
              return AbsorbPointer(
                absorbing: playerTurnSnapshot.hasData && playerTurnSnapshot.data != Player_Type.CURRENT_PLAYER,
                child: GestureDetector(
                  onTap: (){

                    if (currentNodeModel.is_selected){
                      currentNodeModel.is_selected = false;

                      _bloc.clickedNodeModelBehaviorSubject.add(currentNodeModel);
                    }else{
                      currentNodeModel.is_selected = true;

                      _bloc.clickedNodeModelBehaviorSubject.add(currentNodeModel);
                    }

                    gameBoardModel.initial_state[rowIndex][columnIndex] = currentNodeModel;
                    _bloc.gameBoardModelBehaviorSubject.add(gameBoardModel);
                  },
                  child: Animator(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 500),
                    cycles: double.maxFinite.toInt(),
                    curve: Curves.linear,
                    builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                      return StreamBuilder<Player_Type>(
                        stream: _bloc.playerTurnBehaviorSubject.stream,
                        builder: (context, snapshot) {

                          if (snapshot.hasData){
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: LayoutConstants.circle_vertical_padding(context)!,
                                  horizontal: LayoutConstants.circle_horizontal_padding(context)!
                              ),
                              child: currentNodeModel.is_selected? Container(
                                width: LayoutConstants.circle_size(context),
                                height: LayoutConstants.circle_size(context),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(LayoutConstants.circle_size(context)!),
                                    border: Border.all(color: Theme.of(context).primaryColor,
                                        width: LayoutConstants.circle_thickness_size(context)!,
                                        style: BorderStyle.solid),
                                    boxShadow: [
                                      BoxShadow(
                                        color: snapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent,
                                        blurRadius: 5.0 * animatorState.value, // soften the shadow
                                        spreadRadius: 5.0 * animatorState.value, //extend the shadow
                                      )
                                    ]
                                ),
                              ): Container(
                                width: LayoutConstants.circle_size(context),
                                height: LayoutConstants.circle_size(context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(LayoutConstants.circle_size(context)!),
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: snapshot.data == Player_Type.CURRENT_PLAYER? Colors.greenAccent: Colors.orangeAccent,
                                        blurRadius: 5.0 * animatorState.value, // soften the shadow
                                        spreadRadius: 5.0 * animatorState.value, //extend the shadow
                                      )
                                    ]
                                ),
                              ),
                            );
                          }
                          else{
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: LayoutConstants.circle_vertical_padding(context)!,
                                  horizontal: LayoutConstants.circle_horizontal_padding(context)!
                              ),
                              child: currentNodeModel.is_selected? Container(
                                width: LayoutConstants.circle_size(context),
                                height: LayoutConstants.circle_size(context),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(LayoutConstants.circle_size(context)!),
                                    border: Border.all(color: Theme.of(context).primaryColor,
                                        width: LayoutConstants.circle_thickness_size(context)!,
                                        style: BorderStyle.solid),
                                ),
                              ): Container(
                                width: LayoutConstants.circle_size(context),
                                height: LayoutConstants.circle_size(context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(LayoutConstants.circle_size(context)!),
                                    color: Theme.of(context).primaryColor
                                ),
                              ),
                            );
                          }


                        }
                      );

                    },
                  ),

                ),
              );
            }
          ): Opacity(
            opacity: 0.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: LayoutConstants.circle_vertical_padding(context)!,
                  horizontal: LayoutConstants.circle_horizontal_padding(context)!
              ),
              child: Container(
                width: LayoutConstants.circle_size(context),
                height: LayoutConstants.circle_size(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LayoutConstants.circle_size(context)!),
                    color: Theme.of(context).primaryColor
                ),
              ),
            ),

          ),
        );

        if (rowIndex == 0){
          widgetsRowList_One.add(widget);
        }
        else if (rowIndex == 1){
          widgetsRowList_Two.add(widget);
        }
        else if (rowIndex == 2){
          widgetsRowList_Three.add(widget);
        }

      }

    }

    Widget lineWidget = Container(
      width: 200.0,
      height: 2.0,
      color: Theme.of(context).primaryColor,
    );


    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widgetsRowList_One,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widgetsRowList_Two,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetsRowList_Three,
          ),
        ],
      ),
    );
  }

}
