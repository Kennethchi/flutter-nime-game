import 'package:flutter/cupertino.dart';
import 'package:nimle/modules/game_stage/game_stage_bloc.dart';


class GameStageBlocProvider extends InheritedWidget{

  final GameStageBloc bloc;
  final Widget child;
  final Key? key;


  GameStageBlocProvider({
    required this.bloc,
    this.key,
    required this.child
  }): super(key: key, child: child);

  static GameStageBlocProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<GameStageBlocProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}