import 'package:nimle/res/models/node_model.dart';


class GameBoardModel{
  static const int max_rows = 3;
  static const int max_columns = 7;

  List<List<NodeModel>> initial_state = List.generate(max_rows,
          (i) => List.filled(max_columns, NodeModel(is_enabled: false, is_selected: false), growable: false),
      growable: false);


  GameBoardModel(){



    for (int i = 0; i < max_rows; ++i){
      for (int j = 0; j < max_columns; ++j){
        initial_state[i][j] = NodeModel(is_enabled: false, is_selected: false);
        initial_state[i][j].row_index = i;
        initial_state[i][j].column_index = j;
      }
    }

    for (int i = 0; i < max_rows; ++i){

      for (int j = 0; j < max_columns; ++j){

        if (i == 0){

          if (j >= 2 && j <= 4){
           initial_state[i][j].is_enabled = true;
          }
        }
        else if(i == 1){

          if (j >= 1 && j <= 5){
            initial_state[i][j].is_enabled = true;
          }
        }
        else if(i == 2){

          if (j >= 0 && j <= 6){
            initial_state[i][j].is_enabled = true;
          }
        }

      }
    }

  }

}