

import 'dart:html';
import 'dart:math';
import 'package:collection/collection.dart';

import 'package:nimle/res/constants/constants.dart';
import 'package:nimle/res/models/game_boad_model.dart';
import 'package:nimle/res/models/node_model.dart';
import 'package:nimle/res/models/player_stats_model.dart';
import 'package:nimle/res/models/selected_nodes_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GameStageBlocBlueprint{

  
  void dispose();
}


class GameStageBloc implements GameStageBlocBlueprint{

  GameBoardModel _gameBoardModel = GameBoardModel();
  GameBoardModel get gameBoardModel => _gameBoardModel;
  set gameBoardModel(GameBoardModel gameBoardModel) {
    _gameBoardModel = gameBoardModel;
  }

  PlayerStatsModel _playerStatsModel = PlayerStatsModel();
  PlayerStatsModel get playerStatsModel => _playerStatsModel;
  set playerStatsModel(PlayerStatsModel playerStatsModel) {
    _playerStatsModel = playerStatsModel;
  }

  AI_Difficulty _ai_difficulty = AI_Difficulty.EASY;
  AI_Difficulty get ai_difficulty => _ai_difficulty;
  set ai_difficulty(AI_Difficulty ai_difficulty) {
    _ai_difficulty = ai_difficulty;
  }

  Player_Type? _playerWinner;
  Player_Type? get playerWinner => _playerWinner;
  set playerWinner(Player_Type? playerWinner) {
    _playerWinner = playerWinner;
  }

  int _totalNodesLeft = Game_Constants.number_of_nodes;
  int get totalNodesLeft => _totalNodesLeft;
  set totalNodesLeft(int totalNodesLeft) {
    _totalNodesLeft = totalNodesLeft;
  }

  int _previousTotalNodesLeft = Game_Constants.number_of_nodes;
  int get previousTotalNodesLeft => _previousTotalNodesLeft;
  set previousTotalNodesLeft(int previousTotalNodesLeft) {
    _previousTotalNodesLeft = previousTotalNodesLeft;
  }

  Set<int> _rowsSelectedIndexes = Set<int>();
  Set<int> get rowsSelectedIndexes => _rowsSelectedIndexes;
  set rowsSelectedIndexes(Set<int> rowsSelectedIndexes) {
    _rowsSelectedIndexes = rowsSelectedIndexes;
  }

  Set<int> _numRowsSelected = Set<int>();
  Set<int> get numRowsSelected => _numRowsSelected;
  set numRowsSelected(Set<int> numRowsSelected) {
    _numRowsSelected = numRowsSelected;
  }

  Set<int> _columnsSelectedIndexes_RowOne = Set<int>();
  Set<int> get columnsSelectedIndexes_RowOne => _columnsSelectedIndexes_RowOne;
  set columnsSelectedIndexes_RowOne(Set<int> columnsSelectedIndexes_RowOne) {
    _columnsSelectedIndexes_RowOne = columnsSelectedIndexes_RowOne;
  }

  Set<int> _columnsSelectedIndexes_RowTwo = Set<int>();
  Set<int> get columnsSelectedIndexes_RowTwo => _columnsSelectedIndexes_RowTwo;
  set columnsSelectedIndexes_RowTwo(Set<int> columnsSelectedIndexes_RowTwo) {
    _columnsSelectedIndexes_RowTwo = columnsSelectedIndexes_RowTwo;
  }

  Set<int> _columnsSelectedIndexes_RowThree = Set<int>();
  Set<int> get columnsSelectedIndexes_RowThree => _columnsSelectedIndexes_RowThree;
  set columnsSelectedIndexes_RowThree(Set<int> columnsSelectedIndexes_RowThree) {
    _columnsSelectedIndexes_RowThree = columnsSelectedIndexes_RowThree;
  }

  BehaviorSubject<GameBoardModel> gameBoardModelBehaviorSubject = BehaviorSubject<GameBoardModel>();
  BehaviorSubject<Set<int>> rowSelectedIndexesBehaviorSubject = BehaviorSubject<Set<int>>();
  BehaviorSubject<NodeModel> clickedNodeModelBehaviorSubject = BehaviorSubject<NodeModel>();


  BehaviorSubject<Player_Type> playerTurnBehaviorSubject = BehaviorSubject<Player_Type>();
  BehaviorSubject<Player_Type> playerWinnerBehaviorSubject = BehaviorSubject<Player_Type>();

  BehaviorSubject<int> totalNodesLeftBehaviorSubject = BehaviorSubject<int>();

  BehaviorSubject<AI_Difficulty> aiDifficultyBehaviorSubject = BehaviorSubject<AI_Difficulty>();

  BehaviorSubject<PlayerStatsModel> playerStatsModelBehaviorSubject = BehaviorSubject<PlayerStatsModel>();


  GameStageBloc(){

    resetGame();


    clickedNodeModelBehaviorSubject.listen((currentNodeModel) {
      if (currentNodeModel.is_selected){


        rowsSelectedIndexes.add(currentNodeModel.row_index!);
        numRowsSelected.add(currentNodeModel.row_index!);

        if (currentNodeModel.row_index == 0){
          columnsSelectedIndexes_RowOne.add(currentNodeModel.column_index!);
        }
        else if (currentNodeModel.row_index == 1){
          columnsSelectedIndexes_RowTwo.add(currentNodeModel.column_index!);
        }
        else if (currentNodeModel.row_index == 2){
          columnsSelectedIndexes_RowThree.add(currentNodeModel.column_index!);
        }
      }
      else{

        if (currentNodeModel.row_index == 0){
          columnsSelectedIndexes_RowOne.remove(currentNodeModel.column_index!);

          if  (columnsSelectedIndexes_RowOne.isEmpty){
            rowsSelectedIndexes.remove(currentNodeModel.row_index);
            numRowsSelected.remove(currentNodeModel.row_index);

          }
          else{
            numRowsSelected.remove(currentNodeModel.row_index);
          }

        }
        else if (currentNodeModel.row_index == 1){
          columnsSelectedIndexes_RowTwo.remove(currentNodeModel.column_index!);

          if  (columnsSelectedIndexes_RowTwo.isEmpty){
            rowsSelectedIndexes.remove(currentNodeModel.row_index);
            numRowsSelected.remove(currentNodeModel.row_index);
          }
          else{
            numRowsSelected.remove(currentNodeModel.row_index);
          }
        }
        else if (currentNodeModel.row_index == 2){
          columnsSelectedIndexes_RowThree.remove(currentNodeModel.column_index!);

          if  (columnsSelectedIndexes_RowThree.isEmpty){
            rowsSelectedIndexes.remove(currentNodeModel.row_index);
            numRowsSelected.remove(currentNodeModel.row_index);
          }
          else{
            numRowsSelected.remove(currentNodeModel.row_index);
          }
        }


      }

      gameBoardModel.initial_state[currentNodeModel.row_index!][currentNodeModel.column_index!] = currentNodeModel;
      gameBoardModelBehaviorSubject.add(gameBoardModel);

      rowSelectedIndexesBehaviorSubject.add(rowsSelectedIndexes);
    });

    rowSelectedIndexesBehaviorSubject.listen((value) {

    });

    gameBoardModelBehaviorSubject.listen((value) {

    });

    playerTurnBehaviorSubject.listen((player_turn) async{

      if (player_turn ==  Player_Type.AI && totalNodesLeft > 0){

        SelectedNodesModel? selectedNodesModel = await ai_action(ai_difficulty: this.ai_difficulty);

        if (selectedNodesModel != null){

          rowsSelectedIndexes.add(selectedNodesModel.selected_row_index);

          for (int index = 0;  index < selectedNodesModel.selected_columns_index.length; ++index){

            await Future.delayed(Duration(milliseconds: 700), (){

              NodeModel currentNodeModel = NodeModel(
                is_selected: true,
                row_index: selectedNodesModel.selected_row_index,
                column_index: selectedNodesModel.selected_columns_index[index]
              );

              if (selectedNodesModel.selected_row_index == 0){
                columnsSelectedIndexes_RowOne.add(currentNodeModel.column_index!);
              }
              else if (selectedNodesModel.selected_row_index == 1){
                columnsSelectedIndexes_RowTwo.add(currentNodeModel.column_index!);
              }
              else if (selectedNodesModel.selected_row_index == 2){
                columnsSelectedIndexes_RowThree.add(currentNodeModel.column_index!);
              }

              gameBoardModel.initial_state[currentNodeModel.row_index!][currentNodeModel.column_index!].is_selected = true;
            });

            gameBoardModelBehaviorSubject.add(gameBoardModel);
          }

          rowSelectedIndexesBehaviorSubject.add(rowsSelectedIndexes);


          await Future.delayed(Duration(milliseconds: 500), (){});
          disableSelectedNodes();
          await Future.delayed(Duration(milliseconds: 700), (){});
          gameBoardModelBehaviorSubject.add(gameBoardModel);


          clearPlayerTurnState();
          updateTotalNodesLeft();
          previousTotalNodesLeft = totalNodesLeft;


          playerTurnBehaviorSubject.add(Player_Type.CURRENT_PLAYER);

          if (totalNodesLeft == 0){
            playerWinnerBehaviorSubject.add(Player_Type.CURRENT_PLAYER);
          }
        }


      }
      else if (player_turn == Player_Type.CURRENT_PLAYER){

      }

    });

    totalNodesLeftBehaviorSubject.listen((value) {
      totalNodesLeft = value;
    });

    playerWinnerBehaviorSubject.listen((playerWinner) {
      playerWinner = playerWinner;

      switch(ai_difficulty){

        case AI_Difficulty.EASY:
          playerStatsModel.total_matches_vs_easy += 1;
          if (playerWinner == Player_Type.CURRENT_PLAYER){
            playerStatsModel.total_wins_vs_easy += 1;
          }else{
            playerStatsModel.total_losses_vs_easy += 1;
          }
          playerStatsModel.saveStatsInCache().then((_){
            playerStatsModelBehaviorSubject.add(playerStatsModel);
          });
          break;
        case AI_Difficulty.NORMAL:
          playerStatsModel.total_matches_vs_normal += 1;
          if (playerWinner == Player_Type.CURRENT_PLAYER){
            playerStatsModel.total_wins_vs_normal += 1;
          }else{
            playerStatsModel.total_losses_vs_normal += 1;
          }
          playerStatsModel.saveStatsInCache().then((_){
            playerStatsModelBehaviorSubject.add(playerStatsModel);
          });
          break;
        case AI_Difficulty.HARD:
          playerStatsModel.total_matches_vs_hard += 1;
          if (playerWinner == Player_Type.CURRENT_PLAYER){
            playerStatsModel.total_wins_vs_hard += 1;
          }else{
            playerStatsModel.total_losses_vs_hard += 1;
          }
          playerStatsModel.saveStatsInCache().then((_){
            playerStatsModelBehaviorSubject.add(playerStatsModel);
          });
          break;
        case AI_Difficulty.INSANE:
          playerStatsModel.total_matches_vs_insane += 1;

          if (playerWinner == Player_Type.CURRENT_PLAYER){
            playerStatsModel.total_wins_vs_insane += 1;
          }else{
            playerStatsModel.total_losses_vs_insane += 1;
          }
          playerStatsModel.saveStatsInCache().then((_){
            playerStatsModelBehaviorSubject.add(playerStatsModel);
          });
          break;
      }

    });

    aiDifficultyBehaviorSubject.listen((value) {
      ai_difficulty = value;
    });

    getDifficultyLevel().then((value){
      if (value != null){
        aiDifficultyBehaviorSubject.add(value);
      }
      else{
        storeDifficultyLevel(ai_difficulty: AiDifficulty.easy).then((value){

          getDifficultyLevel().then((value){
            if(value != null) {
              aiDifficultyBehaviorSubject.add(value);
            }
          });
        });
      }
    });

    getIfPlayerStatsAvailable().then((isPlayerStatsAvailable)async{

      if (isPlayerStatsAvailable != null && isPlayerStatsAvailable){
        PlayerStatsModel playerStatsModel = PlayerStatsModel();
        await playerStatsModel.loadStatsInCache();
        playerStatsModelBehaviorSubject.add(playerStatsModel);

      }
      else{
        initialisePlayerStatsAvailable().then((_)async{
          PlayerStatsModel playerStatsModel = PlayerStatsModel();
          await playerStatsModel.saveStatsInCache();
          await playerStatsModel.loadStatsInCache();
          playerStatsModelBehaviorSubject.add(playerStatsModel);
        });
      }
    });

    playerStatsModelBehaviorSubject.listen((value) {
      this.playerStatsModel = value;
    });

  }



  Future<bool> getIfPlayerStatsAvailable()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "player_stats_available";
    if (prefs.getBool(key) != null && prefs.getBool(key)!){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> initialisePlayerStatsAvailable()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "player_stats_available";
    prefs.setBool(key, true);
  }


  Future<void> storeDifficultyLevel({required String ai_difficulty})async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = "difficulty_level";

    prefs.setString(key, ai_difficulty);

  }

  Future<AI_Difficulty?> getDifficultyLevel()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = "difficulty_level";

    String? value = prefs.getString(key);
    if (value != null){
      if (value == AiDifficulty.easy){
        return AI_Difficulty.EASY;
      }
      else if (value == AiDifficulty.normal){
        return AI_Difficulty.NORMAL;
      }
      else if (value == AiDifficulty.hard){
        return AI_Difficulty.HARD;
      }
      else if (value == AiDifficulty.insane){
        return AI_Difficulty.INSANE;
      }

    }

  }


  Future<SelectedNodesModel?> ai_action({AI_Difficulty ai_difficulty = AI_Difficulty.EASY})async{

    Random random = Random();

    switch(ai_difficulty){

      case AI_Difficulty.EASY:
        if (totalNodesLeft <= 3){
          return await ai_optimal_action();
        }
        else{
          return await ai_random_action();
        }
      case AI_Difficulty.NORMAL:
        double epsilon = 0.5;
        if (totalNodesLeft <= 5){
          return await ai_optimal_action();
        }
        else if (random.nextDouble() <= epsilon){
          return await ai_random_action();
        }
        else{
          return await ai_optimal_action();
        }
      case AI_Difficulty.HARD:
        double epsilon = 0.2;
        if (totalNodesLeft <= 10){
          return await ai_optimal_action();
        }
        else if (random.nextDouble() <= epsilon){
          return await ai_random_action();
        }
        else{
          return await ai_optimal_action();
        }
      case AI_Difficulty.INSANE:
        // TODO: Handle this case.
        return ai_optimal_action();

      default:
        return ai_optimal_action();
    }

  }



  Future<SelectedNodesModel?> ai_random_action() async {
    
    Set<int> completeRowList = Set<int>();
    completeRowList.addAll([0, 1, 2]);
    
    Set<int> completeColumnRowOneList = Set<int>();
    completeColumnRowOneList.addAll([2, 3, 4]);

    Set<int> completeColumnRowTwoList = Set<int>();
    completeColumnRowTwoList.addAll([1, 2, 3, 4, 5]);

    Set<int> completeColumnRowThreeList = Set<int>();
    completeColumnRowThreeList.addAll([0, 1, 2, 3, 4, 5, 6]);



    Set<int> availableRowList = Set<int>();
    //completeRowList.removeAll(rowsSelectedIndexes);

    Set<int> availableColumnRowOneList = Set<int>();
    completeColumnRowOneList.removeAll(columnsSelectedIndexes_RowOne);

    Set<int> availableColumnRowTwoList = Set<int>();
    completeColumnRowTwoList.removeAll(columnsSelectedIndexes_RowTwo);

    Set<int> availableColumnRowThreeList = Set<int>();
    completeColumnRowThreeList.removeAll(columnsSelectedIndexes_RowThree);

    Random random = Random();

    int selectedRow;

    while(true){
      selectedRow = completeRowList.elementAt(random.nextInt(completeRowList.length));
      if (selectedRow == 0 && completeColumnRowOneList.length > 0){
        break;
      }
      else if (selectedRow == 1 && completeColumnRowTwoList.length > 0){
        break;
      }
      else if (selectedRow == 2 && completeColumnRowThreeList.length > 0){
        break;
      }

    }

    if (selectedRow == 0){

      Set<int> selectedColumns = Set<int>();

      //int numColumnsToChoose = completeColumnRowOneList.elementAt(random.nextInt(completeColumnRowOneList.length));
      int numColumnsToChoose = random.nextInt(completeColumnRowOneList.length) + 1;
      List<int> tempList = completeColumnRowOneList.toList();
      for (int i = 1; i <= numColumnsToChoose; ++i ){
        tempList.shuffle();
        selectedColumns.add(tempList.first);
        tempList.remove(tempList.first);
      }

      SelectedNodesModel selectedNodesModel = SelectedNodesModel(
          selected_row_index: selectedRow,
          selected_columns_index: selectedColumns.toList()
      );
      return selectedNodesModel;
    }
    else if (selectedRow == 1){

      Set<int> selectedColumns = Set<int>();

      //int numColumnsToChoose = completeColumnRowTwoList.elementAt(random.nextInt(completeColumnRowTwoList.length));
      int numColumnsToChoose = random.nextInt(completeColumnRowTwoList.length) + 1;
      List<int> tempList = completeColumnRowTwoList.toList();
      for (int i = 1; i <= numColumnsToChoose; ++i ){
        tempList.shuffle();
        selectedColumns.add(tempList.first);
        tempList.remove(tempList.first);
      }

      SelectedNodesModel selectedNodesModel = SelectedNodesModel(
          selected_row_index: selectedRow,
          selected_columns_index: selectedColumns.toList()
      );
      return selectedNodesModel;
    }
    else if (selectedRow == 2){

      Set<int> selectedColumns= Set<int>();

      //int numColumnsToChoose = completeColumnRowThreeList.elementAt(random.nextInt(completeColumnRowThreeList.length));
      int numColumnsToChoose = random.nextInt(completeColumnRowThreeList.length) + 1;
      List<int> tempList = completeColumnRowThreeList.toList();
      for (int i = 1; i <= numColumnsToChoose; ++i ){
        tempList.shuffle();
        selectedColumns.add(tempList.first);
        tempList.remove(tempList.first);
      }

      SelectedNodesModel selectedNodesModel = SelectedNodesModel(
          selected_row_index: selectedRow,
          selected_columns_index: selectedColumns.toList()
      );

      return selectedNodesModel;
    }

  }



  Future<SelectedNodesModel?> ai_optimal_action() async {


    int num_steps = 100;
    for (int step = 0; step < num_steps; ++step){

      // Initialisation
      Set<int> completeColumnRowOneList = Set<int>();
      completeColumnRowOneList.addAll([2, 3, 4]);
      Set<int> completeColumnRowTwoList = Set<int>();
      completeColumnRowTwoList.addAll([1, 2, 3, 4, 5]);
      Set<int> completeColumnRowThreeList = Set<int>();
      completeColumnRowThreeList.addAll([0, 1, 2, 3, 4, 5, 6]);
      completeColumnRowOneList.removeAll(columnsSelectedIndexes_RowOne);
      completeColumnRowTwoList.removeAll(columnsSelectedIndexes_RowTwo);
      completeColumnRowThreeList.removeAll(columnsSelectedIndexes_RowThree);


      if((completeColumnRowOneList.isNotEmpty && completeColumnRowTwoList.isEmpty && completeColumnRowThreeList.isEmpty) ||
          (completeColumnRowTwoList.isNotEmpty && completeColumnRowOneList.isEmpty && completeColumnRowThreeList.isEmpty) ||
          (completeColumnRowThreeList.isNotEmpty && completeColumnRowOneList.isEmpty && completeColumnRowTwoList.isEmpty)
      ){

        if (completeColumnRowOneList.isNotEmpty && completeColumnRowTwoList.isEmpty && completeColumnRowThreeList.isEmpty){
          if (completeColumnRowOneList.length > 1){
            Set<int> selectedColumns = Set<int>();

            int numColumnsToChoose = completeColumnRowOneList.length - 1;

            List<int> tempList = completeColumnRowOneList.toList();
            for (int i = 1; i <= numColumnsToChoose; ++i ){
              tempList.shuffle();
              selectedColumns.add(tempList.first);
              tempList.remove(tempList.first);
            }

            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 0,
                selected_columns_index: selectedColumns.toList()
            );

            return selectedNodesModel;
          }
          else{
            return await ai_random_action();
          }
        }
        else if (completeColumnRowTwoList.isNotEmpty && completeColumnRowOneList.isEmpty && completeColumnRowThreeList.isEmpty){



          if (completeColumnRowTwoList.length > 1){

            Set<int> selectedColumns = Set<int>();

            int numColumnsToChoose = completeColumnRowTwoList.length - 1;

            List<int> tempList = completeColumnRowTwoList.toList();
            for (int i = 1; i <= numColumnsToChoose; ++i ){
              tempList.shuffle();
              selectedColumns.add(tempList.first);
              tempList.remove(tempList.first);
            }

            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 1,
                selected_columns_index: selectedColumns.toList()
            );

            return selectedNodesModel;
          }
          else{

            return await ai_random_action();
          }
        }
        else if (completeColumnRowThreeList.isNotEmpty && completeColumnRowOneList.isEmpty && completeColumnRowTwoList.isEmpty){
          if (completeColumnRowThreeList.length > 1){
            Set<int> selectedColumns = Set<int>();

            int numColumnsToChoose = completeColumnRowThreeList.length - 1;

            List<int> tempList = completeColumnRowThreeList.toList();
            for (int i = 1; i <= numColumnsToChoose; ++i ){
              tempList.shuffle();
              selectedColumns.add(tempList.first);
              tempList.remove(tempList.first);
            }

            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 2,
                selected_columns_index: selectedColumns.toList()
            );

            return selectedNodesModel;
          }
          else{
            return await ai_random_action();
          }
        }
        else{

          return await ai_random_action();
        }

      }
      else if (completeColumnRowOneList.length == completeColumnRowTwoList.length &&
          (completeColumnRowOneList.length > 1 || completeColumnRowTwoList.length > 1)
      ){

        if (completeColumnRowThreeList.isNotEmpty){
          SelectedNodesModel selectedNodesModel = SelectedNodesModel(
              selected_row_index: 2,
              selected_columns_index: completeColumnRowThreeList.toList());
          return selectedNodesModel;
        }
        else{

          return await ai_random_action();
        }
      }
      else if (completeColumnRowOneList.length == completeColumnRowThreeList.length &&
          (completeColumnRowOneList.length > 1 || completeColumnRowThreeList.length > 1)
      ){

        if (completeColumnRowTwoList.isNotEmpty){
          SelectedNodesModel selectedNodesModel = SelectedNodesModel(
              selected_row_index: 1,
              selected_columns_index: completeColumnRowTwoList.toList());
          return selectedNodesModel;
        }
        else{
          return await ai_random_action();
        }
      }
      else if (completeColumnRowTwoList.length == completeColumnRowThreeList.length &&
          (completeColumnRowTwoList.length > 1 || completeColumnRowThreeList.length > 1)
      ){

        if (completeColumnRowOneList.isNotEmpty){
          SelectedNodesModel selectedNodesModel = SelectedNodesModel(
              selected_row_index: 0,
              selected_columns_index: completeColumnRowOneList.toList());
          return selectedNodesModel;
        }
        else{
          return await ai_random_action();
        }
      }
      else if (completeColumnRowOneList.isEmpty || completeColumnRowTwoList.isEmpty || completeColumnRowThreeList.isEmpty){

        if (completeColumnRowOneList.isEmpty && (completeColumnRowTwoList.isNotEmpty && completeColumnRowThreeList.isNotEmpty)){
          if (completeColumnRowTwoList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 2,
                selected_columns_index: completeColumnRowThreeList.toList());
            return selectedNodesModel;
          }
          else if (completeColumnRowThreeList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 1,
                selected_columns_index: completeColumnRowTwoList.toList());
            return selectedNodesModel;
          }
          else{

            if (completeColumnRowTwoList.length > completeColumnRowThreeList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowTwoList.length - completeColumnRowThreeList.length).abs();

              List<int> tempList = completeColumnRowTwoList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 1,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }
            else if (completeColumnRowThreeList.length > completeColumnRowTwoList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowThreeList.length - completeColumnRowTwoList.length).abs();

              List<int> tempList = completeColumnRowThreeList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 2,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }


            return await ai_random_action();
          }
        }
        else if (completeColumnRowTwoList.isEmpty && (completeColumnRowOneList.isNotEmpty && completeColumnRowThreeList.isNotEmpty)){
          if (completeColumnRowOneList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 2,
                selected_columns_index: completeColumnRowThreeList.toList());
            return selectedNodesModel;
          }
          else if (completeColumnRowThreeList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 0,
                selected_columns_index: completeColumnRowOneList.toList());
            return selectedNodesModel;
          }
          else{

            if (completeColumnRowOneList.length > completeColumnRowThreeList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowOneList.length - completeColumnRowThreeList.length).abs();

              List<int> tempList = completeColumnRowOneList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 0,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }
            else if (completeColumnRowThreeList.length > completeColumnRowOneList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowThreeList.length - completeColumnRowOneList.length).abs();

              List<int> tempList = completeColumnRowThreeList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 2,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }

            return await ai_random_action();
          }
        }
        else if (completeColumnRowThreeList.isEmpty && (completeColumnRowOneList.isNotEmpty && completeColumnRowTwoList.isNotEmpty)){
          if (completeColumnRowOneList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 1,
                selected_columns_index: completeColumnRowTwoList.toList());
            return selectedNodesModel;
          }
          else if (completeColumnRowTwoList.length == 1){
            SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                selected_row_index: 0,
                selected_columns_index: completeColumnRowOneList.toList());
            return selectedNodesModel;
          }
          else{

            if (completeColumnRowOneList.length > completeColumnRowTwoList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowOneList.length - completeColumnRowTwoList.length).abs();

              List<int> tempList = completeColumnRowOneList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 0,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }
            else if (completeColumnRowTwoList.length > completeColumnRowOneList.length){
              Set<int> selectedColumns = Set<int>();

              int numColumnsToChoose = (completeColumnRowTwoList.length - completeColumnRowOneList.length).abs();

              List<int> tempList = completeColumnRowTwoList.toList();
              for (int i = 1; i <= numColumnsToChoose; ++i ){
                tempList.shuffle();
                selectedColumns.add(tempList.first);
                tempList.remove(tempList.first);
              }

              SelectedNodesModel selectedNodesModel = SelectedNodesModel(
                  selected_row_index: 1,
                  selected_columns_index: selectedColumns.toList()
              );

              return selectedNodesModel;
            }

            return await ai_random_action();
          }
        }
        else{
          return await ai_random_action();
        }
      }
      else{
        SelectedNodesModel? selectedNodesModel = await ai_random_action();
        if (selectedNodesModel != null){
          List<List<int>> winningCombination = List.filled(0, [], growable: true);
          winningCombination.add([1, 1, 1]);
          winningCombination.add([1, 2, 3]);
          winningCombination.add([2, 4, 6]);
          winningCombination.add([1, 4, 5]);

          if (selectedNodesModel.selected_row_index == 0){
            completeColumnRowOneList.removeAll(selectedNodesModel.selected_columns_index);
          }
          else if (selectedNodesModel.selected_row_index == 1){
            completeColumnRowTwoList.removeAll(selectedNodesModel.selected_columns_index);
          }
          else if (selectedNodesModel.selected_row_index == 2){
            completeColumnRowThreeList.removeAll(selectedNodesModel.selected_columns_index);
          }

          List<int> rowSizes = List.filled(0, 0, growable: true);
          rowSizes.addAll([completeColumnRowOneList.length
            , completeColumnRowTwoList.length
            , completeColumnRowThreeList.length
          ]);
          rowSizes.sort();

          print("Step ${step}");
          Function eq = const ListEquality().equals;
          //Function deepEq = const DeepCollectionEquality().equals;
          for (List<int> winCombin in winningCombination){

            print("${rowSizes}          ${winCombin}");

            if(eq(rowSizes, winCombin)){
              print("Found Winning combination ${rowSizes}");
              print("\n\n");
              return selectedNodesModel;
            }
          }

        }
      }

    }

    print("Went till the end: ${num_steps} times");
    return await ai_random_action();
  }


  void clearPlayerTurnState(){
    numRowsSelected.clear();
    //columnsSelectedIndexes_RowOne.clear();
    //columnsSelectedIndexes_RowTwo.clear();
    //columnsSelectedIndexes_RowThree.clear();
  }


  void disableSelectedNodes(){


    for (int i = 0; i < GameBoardModel.max_rows; ++i){

      for (int j = 0; j < GameBoardModel.max_columns; ++j){

        if (i == 0){
          if (j >= 2 && j <= 4 && gameBoardModel.initial_state[i][j].is_selected){
            gameBoardModel.initial_state[i][j].is_enabled = false;
          }
        }
        else if(i == 1){
          if (j >= 1 && j <= 5 && gameBoardModel.initial_state[i][j].is_selected){
            gameBoardModel.initial_state[i][j].is_enabled = false;
          }
        }
        else if(i == 2){
          if (j >= 0 && j <= 6  && gameBoardModel.initial_state[i][j].is_selected){
            gameBoardModel.initial_state[i][j].is_enabled = false;
          }
        }
      }
    }
  }


  int updateTotalNodesLeft(){
    int newTotalNodesLeft = Game_Constants.number_of_nodes - (columnsSelectedIndexes_RowOne.length
        + columnsSelectedIndexes_RowTwo.length
        + columnsSelectedIndexes_RowThree.length);

    totalNodesLeft = newTotalNodesLeft;
    totalNodesLeftBehaviorSubject.add(newTotalNodesLeft);

    return newTotalNodesLeft;
  }



  void resetGame(){
    numRowsSelected.clear();
    rowsSelectedIndexes.clear();
    columnsSelectedIndexes_RowOne.clear();
    columnsSelectedIndexes_RowTwo.clear();
    columnsSelectedIndexes_RowThree.clear();
    totalNodesLeftBehaviorSubject.add(Game_Constants.number_of_nodes);

    gameBoardModelBehaviorSubject.add(GameBoardModel());

  }
  
  @override
  void dispose() {
    // TODO: implement dispose
  }

}


