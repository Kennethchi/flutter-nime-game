

import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

class PlayerStatsModel{


  int total_matches_vs_easy;
  int total_wins_vs_easy;
  int total_losses_vs_easy;

  int total_matches_vs_normal;
  int total_wins_vs_normal;
  int total_losses_vs_normal;

  int total_matches_vs_hard;
  int total_wins_vs_hard;
  int total_losses_vs_hard;

  int total_matches_vs_insane;
  int total_wins_vs_insane;
  int total_losses_vs_insane;

  PlayerStatsModel({
    this.total_matches_vs_easy = 0,
    this.total_wins_vs_easy = 0,
    this.total_losses_vs_easy = 0,

    this.total_matches_vs_normal = 0,
    this.total_wins_vs_normal = 0,
    this.total_losses_vs_normal = 0,

    this.total_matches_vs_hard = 0,
    this.total_wins_vs_hard = 0,
    this.total_losses_vs_hard = 0,

    this.total_matches_vs_insane = 0,
    this.total_wins_vs_insane = 0,
    this.total_losses_vs_insane = 0
});


  factory PlayerStatsModel.fromJson(Map<dynamic, dynamic> json){

    return PlayerStatsModel(

    );
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    

    return data;
  }

  Future<void> saveStatsInCache()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_PlayerStatsConstantKeys.total_matches_vs_easy, this.total_matches_vs_easy);
    prefs.setInt(_PlayerStatsConstantKeys.total_wins_vs_easy, this.total_wins_vs_easy);
    prefs.setInt(_PlayerStatsConstantKeys.total_losses_vs_easy, this.total_losses_vs_easy);


    prefs.setInt(_PlayerStatsConstantKeys.total_matches_vs_normal, this.total_matches_vs_normal);
    prefs.setInt(_PlayerStatsConstantKeys.total_wins_vs_normal, this.total_wins_vs_normal);
    prefs.setInt(_PlayerStatsConstantKeys.total_losses_vs_normal, this.total_losses_vs_normal);

    prefs.setInt(_PlayerStatsConstantKeys.total_matches_vs_hard, this.total_matches_vs_hard);
    prefs.setInt(_PlayerStatsConstantKeys.total_wins_vs_hard, this.total_wins_vs_hard);
    prefs.setInt(_PlayerStatsConstantKeys.total_losses_vs_hard, this.total_losses_vs_hard);

    prefs.setInt(_PlayerStatsConstantKeys.total_matches_vs_insane, this.total_matches_vs_insane);
    prefs.setInt(_PlayerStatsConstantKeys.total_wins_vs_insane, this.total_wins_vs_insane);
    prefs.setInt(_PlayerStatsConstantKeys.total_losses_vs_insane, this.total_losses_vs_insane);
  }

  Future<void> loadStatsInCache()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.total_matches_vs_easy = prefs.getInt(_PlayerStatsConstantKeys.total_matches_vs_easy)!;
    this.total_wins_vs_easy = prefs.getInt(_PlayerStatsConstantKeys.total_wins_vs_easy)!;
    this.total_losses_vs_easy = prefs.getInt(_PlayerStatsConstantKeys.total_losses_vs_easy)!;

    this.total_matches_vs_normal = prefs.getInt(_PlayerStatsConstantKeys.total_matches_vs_normal)!;
    this.total_wins_vs_normal = prefs.getInt(_PlayerStatsConstantKeys.total_wins_vs_normal)!;
    this.total_losses_vs_normal = prefs.getInt(_PlayerStatsConstantKeys.total_losses_vs_normal)!;

    this.total_matches_vs_hard = prefs.getInt(_PlayerStatsConstantKeys.total_matches_vs_hard)!;
    this.total_wins_vs_hard = prefs.getInt(_PlayerStatsConstantKeys.total_wins_vs_hard)!;
    this.total_losses_vs_hard = prefs.getInt(_PlayerStatsConstantKeys.total_losses_vs_hard)!;

    this.total_matches_vs_insane = prefs.getInt(_PlayerStatsConstantKeys.total_matches_vs_insane)!;
    this.total_wins_vs_insane = prefs.getInt(_PlayerStatsConstantKeys.total_wins_vs_insane)!;
    this.total_losses_vs_insane = prefs.getInt(_PlayerStatsConstantKeys.total_losses_vs_insane)!;
  }


}


class _PlayerStatsConstantKeys{

  static String total_matches_vs_easy = "total_matches_vs_easy";
  static String total_wins_vs_easy = "total_wins_vs_easy";
  static String total_losses_vs_easy = "total_losses_vs_easy";

  static String total_matches_vs_normal = "total_matches_vs_normal";
  static String total_wins_vs_normal = "total_wins_vs_normal";
  static String total_losses_vs_normal = "total_losses_vs_normal";

  static String total_matches_vs_hard = "total_matches_vs_hard";
  static String total_wins_vs_hard = "total_wins_vs_hard";
  static String total_losses_vs_hard = "total_losses_vs_hard";

  static String total_matches_vs_insane = "total_matches_vs_insane";
  static String total_wins_vs_insane = "total_wins_vs_insane";
  static String total_losses_vs_insane = "total_losses_vs_insane";

}