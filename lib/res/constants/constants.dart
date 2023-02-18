

enum Player_Type{
  CURRENT_PLAYER,
  AI,
  ONLINE_PLAYER,
  NONE
}

enum AI_Difficulty{
  EASY,
  NORMAL,
  HARD,
  INSANE
}

class AiDifficulty{
  static String easy = "easy";
  static String normal = "normal";
  static String hard = "hard";
  static String insane = "insane";
}

mixin Game_Constants {
  static const int number_of_nodes = 15;
}

enum MenuOptions{
  HOW_TO_PLAY,
  DIFFICULTY_LEVEL,
  PLAYER_STATS,
  SHARE
}





