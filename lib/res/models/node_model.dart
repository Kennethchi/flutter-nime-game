

class NodeModel{

  bool is_enabled;
  bool is_selected;

  int? row_index;
  int? column_index;

  NodeModel({this.is_enabled = false, this.is_selected = false, this.row_index, this.column_index});

  factory NodeModel.fromJson(Map<dynamic, dynamic> json){

    return NodeModel(
        is_enabled: json["is_enabled"],
        is_selected: json["is_selected"],
      row_index: json["row_index"],
      column_index: json["column_index"]
    );
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    data["is_enabled"] = this.is_enabled;
    data["is_selected"] = this.is_selected;
    data["row_index"] = this.row_index;
    data["column_index"] = this.column_index;

    return data;
  }

}