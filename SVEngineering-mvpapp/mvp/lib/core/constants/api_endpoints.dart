class ApiEndPoints {
  // static const BASE_URL =
  //     "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod/";

  static const BASE_URL =
      "https://e0gcs528ad.execute-api.us-east-1.amazonaws.com/Prod_V2/";
  //LEAGUES URLS
  static const GET_LEAGUES = "leagues";
  static const GET_LEAGUES_KEYWORD = "leagues/keyword";
  static const CREATE_LEAGUE = "leagues/league";
  static const DELETE_LEAGUE = "leagues/league";
  static const UPDATE_LEAGUE = "leagues/update";
  static const UPDATE_TEAM = "leagues/team/update";

  static const GET_GAMES = "games";
  static const CREATE_GAME = "games";
  static const DELETE_GAME = "games";
  static const GET_GAMES_KEYWORD = "games/keyword";

  static const UPDATE_GAME = "games/update";

  //ARENAS URLS
  static const GET_ARENAS = "arenas";
  static const GET_ARENAS_KEYWORD = "arenas/keyword";
  static const CREATE_ARENA = "arenas/arena";
  static const DELETE_ARENA = "arenas/arena";
  static const DELETE_COURT = "arenas/court";
  static const CREATE_COURT = "arenas/court";
  static const UPDATE_ARENA = "arenas/update";

  //TEAM URLS
  static const CREATE_TEAM = "leagues/team";
  static const DELETE_TEAM = "leagues/team";
  static const DELETE_PLAYER = "leagues/player";
}
