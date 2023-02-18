

class SelectedNodesModel{

  int selected_row_index;
  List<int> selected_columns_index;


  SelectedNodesModel({required this.selected_row_index, required this.selected_columns_index});

  factory SelectedNodesModel.fromJson(Map<dynamic, dynamic> json){

    return SelectedNodesModel(
        selected_row_index: json["selected_row_index"],
        selected_columns_index: json["selected_columns_index"]
    );
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    data["selected_row_index"] = this.selected_row_index;
    data["selected_columns_index"] = this.selected_columns_index;

    return data;
  }

}